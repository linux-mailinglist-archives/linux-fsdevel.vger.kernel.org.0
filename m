Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F545E9A0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 11:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfJ3KfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 06:35:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32520 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbfJ3KfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572431709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vMnBP1vJh7DVtSAEiQOC37MaYouJjw4pGK3+A/kZfEE=;
        b=cM8ljuzJEYay75gZmV+oyfNRyuEt79+iU/NIl03OwMj7CqNFqmmIXFEjeV0yalg1EkheTg
        cMnSANZlcKEaVys+n0aH96mfcYVEp/v6WRPyy4A9/ZckonaMjJJwANrvAx3IjIBJ2VhcVQ
        E2F1A+OzrpEH2NGGG8A7r1ORT5uJSRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-nQpbRAfROVGuuPV7vSUXZw-1; Wed, 30 Oct 2019 06:35:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE4321005500;
        Wed, 30 Oct 2019 10:35:04 +0000 (UTC)
Received: from fogou.chygwyn.com (unknown [10.33.36.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96A3910016EB;
        Wed, 30 Oct 2019 10:34:32 +0000 (UTC)
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box>
 <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box>
 <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
From:   Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com>
Date:   Wed, 30 Oct 2019 10:34:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: nQpbRAfROVGuuPV7vSUXZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 29/10/2019 16:52, Linus Torvalds wrote:
> On Tue, Oct 29, 2019 at 3:25 PM Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>> I think all network filesystems which synchronize metadata lazily should=
 be
>> marked. For example as "SB_VOLATILE". And vfs could handle them speciall=
y.
> No need. The VFS layer doesn't call generic_file_buffered_read()
> directly anyway. It's just a helper function for filesystems to use if
> they want to.
>
> They could (and should) make sure the inode size is sufficiently
> up-to-date before calling it. And if they want something more
> synchronous, they can do it themselves.
>
> But NFS, for example, has open/close consistency, so the metadata
> revalidation is at open() time, not at read time.
>
>                 Linus

NFS may be ok here, but it will break GFS2. There may be others too...=20
OCFS2 is likely one. Not sure about CIFS either. Does it really matter=20
that we might occasionally allocate a page and then free it again?

Ramfs is a simple test case, but at the same time it doesn't represent=20
the complexity of a real world filesystem. I'm just back from a few days=20
holiday so apologies if I've missed something earlier on in the discussions=
,

Steve.

