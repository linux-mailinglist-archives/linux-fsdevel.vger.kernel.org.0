Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F345151095
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 20:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgBCT4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 14:56:33 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7366 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgBCT4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:56:33 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e387ad80000>; Mon, 03 Feb 2020 11:56:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 11:56:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 03 Feb 2020 11:56:31 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 19:56:30 +0000
Subject: Re: [PATCH v3 03/12] mm/gup: pass a flags arg to __gup_device_*
 functions
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-4-jhubbard@nvidia.com>
 <20200203131934.pxwmyemhgiqcb5j3@box>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <211b8544-fcfd-b792-5bc6-ce3c57aff668@nvidia.com>
Date:   Mon, 3 Feb 2020 11:56:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203131934.pxwmyemhgiqcb5j3@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580759768; bh=ENd9riUsqlY2vk6FThZWhdHl4vBynDdCmrcmCldeFV4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=K9Z4408QyGMC3ZtZJccyVUqU3zgHbe07hUrdbOmB2HEQjSzmQjGvnBS97XomhmyHk
         XbPr64v94sVALEzN7nklT7IuWj4uc7YOoCsrCiDa45muGEh/6CWYFxhB18NzIImBUU
         1pKGgGD3xNL5jtMiVw2zZ+mvYKNNhanNl0TLqwZQ3+WRhV4Hc8PGYc9OETxFUrgfKt
         m9L5L84RTxTT654UesBdM5jJgSNENL57RDj2pnjNX6lQBKI0pbwmimFH74cXGK4Zpx
         2QvHGqRcMwU9TJQwGZGBXSrbAYGM5dNHfyRBeuBzrvxh5YJ9JnymNcvwNV+bQSYwyJ
         zb7PnpvDgz0uw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/3/20 5:19 AM, Kirill A. Shutemov wrote:
> On Fri, Jan 31, 2020 at 07:40:20PM -0800, John Hubbard wrote:
>> A subsequent patch requires access to gup flags, so pass the flags
>> argument through to the __gup_device_* functions.
>>
>> Also placate checkpatch.pl by shortening a nearby line.
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Reviewed-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>
>=20
> Empty line here?


Yes. No one knows why. :)  Fixed for next posting, thanks!

thanks,
--=20
John Hubbard
NVIDIA

>=20
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>=20
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>=20
