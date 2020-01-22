Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D41F0145B8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 19:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAVS1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 13:27:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5964 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVS1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:27:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2893d10001>; Wed, 22 Jan 2020 10:26:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 22 Jan 2020 10:27:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 22 Jan 2020 10:27:09 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Jan
 2020 18:27:09 +0000
Subject: Re: [Lsf-pc][LSF/MM/BPF TOPIC] Generic page write protection
To:     <jglisse@redhat.com>, <lsf-pc@lists.linux-foundation.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, lsf-pc <lsf-pc@lists.linux-foundation.org>
References: <20200122023222.75347-1-jglisse@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <174cd3a0-43e5-d8bd-5cc3-d562f5727283@nvidia.com>
Date:   Wed, 22 Jan 2020 10:27:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122023222.75347-1-jglisse@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579717585; bh=zM1GZj8JqKU2+u42J7V4E+rUU+HYAAUatSe9FzyeLvo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oKVuFui6iUjT/PoUawkl8P6jpwCGz3cOGcMmtlNAW93lnyegrDlC2dXTN+YzAmJih
         dkOvkbW/KIykbkayZViIbe88ZvDAJ1A8VghOOEubR4K2ays+2YFnKzerEPeSVUutQX
         hl5VJzFOAIbbyYJr2rylGxVQeQwCYhO7yWJS/4XfujGQ/8WKKCY+dcZgR13a4QneZA
         iE1dzJtE11e7sd7C7MLxusF4V7Wo1ATcM6milQiEld3qrEV3QlDKPzKDHRqtDrdbta
         o5Z1SswkBaKNoMw96ohNLDuadmEF4FwbKXBq21nCz9CAxKmHX44dIBN2ocNrVgwGwu
         /WTJ88VrIMZfQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding: lsf-pc

On 1/21/20 6:32 PM, jglisse@redhat.com wrote:
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
>=20
> Provide a generic way to write protect page (=C3=A0 la KSM) to enable new=
 mm
> optimization:
>     - KSM (kernel share memory) to deduplicate pages (for file
>       back pages too not only anonymous memory like today)
>     - page duplication NUMA (read only duplication) in multiple
>       different physical page. For instance share library code
>       having a copy on each NUMA node. Or in case like GPU/FPGA
>       duplicating memory read only inside the local device memory.
>     ...
>=20
> Note that this write protection is intend to be broken at anytime in
> reasonable time (like KSM today) so that we never block more than
> necessary anything that need to write to the page.
>=20
>=20
> The goal is to provide a mechanism that work for both anonymous and
> file back memory. For this we need to a pointer inside struct page.
> For anonymous memory KSM uses the anon_vma field which correspond
> to mapping field for file back pages.
>=20
> So to allow generic write protection for file back pages we need to
> avoid relying on struct page mapping field in the various kernel code
> path that do use it today.
>=20
> The page->mapping fields is use in 5 different ways:
>  [1]- Functions operating on file, we can get the mapping from the file
>       (issue here is that we might need to pass the file down the call-
>       stack)
>=20
>  [2]- Core/arch mm functions, those do not care about the file (if they
>       do then it means they are vma related and we can get the mapping
>       from the vma). Those functions only want to be able to walk all
>       the pte point to the page (for instance memory compaction, memory
>       reclaim, ...). We can provide the exact same functionality for
>       write protected pages (like KSM does today).
>=20
>  [3]- Block layer when I/O fails. This depends on fs, for instance for
>       fs which uses buffer_head we can update buffer_head to store the
>       mapping instead of the block_device as we can get the block_device
>       from the mapping but not the mapping from the block_device.
>=20
>       So solving this is mostly filesystem specific but i have not seen
>       any fs that could not be updated properly so that block layer can
>       report I/O failures without relying on page->mapping
>=20
>  [4]- Debugging (mostly procfs/sysfs files to dump memory states). Those
>       do not need the mapping per say, we just need to report page states
>       (and thus write protection information if page is write protected).
>=20
>  [5]- GUP (get user page) if something calls GUP in write mode then we
>       need to break write protection (like KSM today). GUPed page should
>       not be write protected as we do not know what the GUPers is doing
>       with the page.
>=20
>=20
> Most of the patchset deals with [1], [2] and [3] ([4] and [5] are mostly
> trivial).
>=20
> For [1] we only need to pass down the mapping to all fs and vfs callback
> functions (this is mostly achieve with coccinelle). Roughly speaking the
> patches are generated with following pseudo code:
>=20
> add_mapping_parameter(func)
> {
>     function_add_parameter(func, mapping);
>=20
>     for_each_function_calling (caller, func) {
>         calling_add_parameter(caller, func, mapping);
>=20
>         if (function_parameters_contains(caller, mapping|file))
>             continue;
>=20
>         add_mapping_parameter(caller);
>     }
> }
>=20
> passdown_mapping()
> {
>     for_each_function_in_fs (func, fs_functions) {
>         if (!function_body_contains(func, page->mapping))
>             continue;
>=20
>         if (function_parameters_contains(func, mapping|file))
>             continue;
>=20
>         add_mapping_parameter(func);
>     }
> }
>=20
> For [2] KSM is generalized and extended so that both anonymous and file
> back pages can be handled by a common write protected page case.
>=20
> For [3] it depends on the filesystem (fs which uses buffer_head are
> easily handled by storing mapping into the buffer_head struct).
>=20
>=20
> To avoid any regression risks the page->mapping field is left intact as
> today for non write protect pages. This means that if you do not use the
> page write protection mechanism then it can not regress. This is achieve
> by using an helper function that take the mapping from the context
> (current function parameter, see above on how function are updated) and
> the struct page. If the page is not write protected then it uses the
> mapping from the struct page (just like today). The only difference
> between before and after the patchset is that all fs functions that do
> need the mapping for a page now also do get it as a parameter but only
> use the parameter mapping pointer if the page is write protected.
>=20
> Note also that i do not believe that once confidence is high that we
> always passdown the correct mapping down each callstack, it does not
> mean we will be able to get rid of the struct page mapping field.
>=20
> I posted patchset before [*1] and i intend to post an updated patchset
> before LSF/MM/BPF. I also talked about this at LSF/MM 2018. I still
> believe this will a topic that warrent a discussion with FS/MM and
> block device folks.
>=20
>=20
> [*1] https://lwn.net/Articles/751050/
>      https://cgit.freedesktop.org/~glisse/linux/log/?h=3Dgeneric-write-pr=
otection-rfc
> [*2] https://lwn.net/Articles/752564/
>=20
>=20
> To: lsf-pc@lists.linux-foundation.org
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-block@vger.kernel.org
> Cc: linux-mm@kvack.org
>=20
>=20

thanks,
--=20
John Hubbard
NVIDIA
