Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE155267F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 18:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfEVQSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 12:18:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59405 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbfEVQSz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 12:18:55 -0400
Received: from [IPv6:2607:fb90:3635:972:9c5a:d1ae:8e8f:2fe7] ([IPv6:2607:fb90:3635:972:9c5a:d1ae:8e8f:2fe7])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x4MGIdpA3692384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 22 May 2019 09:18:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x4MGIdpA3692384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558541921;
        bh=luHnu8/JMpI0wULaC++B/hvrgAGxTmtVWSgg46F+QLk=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=xs/vEushcxReVdh/8g68Ic5EU0WidpTQJoNKzhKXTrehDSUxqizAS16k/S4DuKB1E
         IIHyOkuW1wZfO09+WE/+XDKVAYVNgKzmzYsRiBPvP5ee//WRZhhTEGa/fhMhtRhWPW
         kMuvzHcRcrKLGJ/HCparWiKhvDJ43vD4x+x71+8gj78HgvtqfOhFs5jtJkViqnyDNV
         EmWwfqu/gQXCyD7SEqyfRavhklH+YjMptpT5RuCONJIjjV77bncOv+K3eFjyEZUvsg
         QTEwDixFxXfgNGsPNMtmxIISM9jACHD2Uwyzh5Ga7+M5CtoqIM6MrVgW1pEqAcxz5E
         owufomrAHnACQ==
Date:   Wed, 22 May 2019 09:18:36 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <a0afd58f-c682-66b5-7478-c405a179d72a@landley.net>
References: <20190517165519.11507-1-roberto.sassu@huawei.com> <20190517165519.11507-3-roberto.sassu@huawei.com> <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com> <69ef1f55-9fc1-7ee0-371f-3dbc77551dc0@zytor.com> <a0afd58f-c682-66b5-7478-c405a179d72a@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
To:     Rob Landley <rob@landley.net>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        viro@zeniv.linux.org.uk
CC:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        james.w.mcmechan@gmail.com, niveditas98@gmail.com
From:   hpa@zytor.com
Message-ID: <FAF78781-2684-4482-9D4D-445B91C15E97@zytor.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 17, 2019 7:16:04 PM PDT, Rob Landley <rob@landley=2Enet> wrote:
>On 5/17/19 4:41 PM, H=2E Peter Anvin wrote:
>> On 5/17/19 1:18 PM, hpa@zytor=2Ecom wrote:
>>>
>>> Ok=2E=2E=2E I just realized this does not work for a modular initramfs=
,
>composed at load time from multiple files, which is a very real
>problem=2E Should be easy enough to deal with: instead of one large file,
>use one companion file per source file, perhaps something like
>filename=2E=2Exattrs (suggesting double dots to make it less likely to
>conflict with a "real" file=2E) No leading dot, as it makes it more
>likely that archivers will sort them before the file proper=2E
>>>
>>> A side benefit is that the format can be simpler as there is no need
>to encode the filename=2E
>>>
>>> A technically cleaner solution still, but which would need archiver
>modifications, would be to encode the xattrs as an optionally nameless
>file (just an empty string) with a new file mode value, immediately
>following the original file=2E The advantage there is that the archiver
>itself could support xattrs and other extended metadata (which has been
>requested elsewhere); the disadvantage obviously is that that it
>requires new support in the archiver=2E However, at least it ought to be
>simpler since it is still a higher protocol level than the cpio archive
>itself=2E
>>>
>>> There's already one special case in cpio, which is the
>"!!!TRAILER!!!" filename; although I don't think it is part of the
>formal spec, to the extent there is one, I would expect that in
>practice it is always encoded with a mode of 0, which incidentally
>could be used to unbreak the case where such a filename actually
>exists=2E So one way to support such extended metadata would be to set
>mode to 0 and use the filename to encode the type of metadata=2E I wonder
>how existing GNU or BSD cpio (the BSD one is better maintained these
>days) would deal with reading such a file; it would at least not be a
>regression if it just read it still, possibly with warnings=2E It could
>also be possible to use bits 17:16 in the mode, which are traditionally
>always zero (mode_t being 16 bits), but I believe are present in most
>or all of the cpio formats for historical reasons=2E It might be accepted
>better by existing implementations to use one of these high bits
>combined with S_IFREG, I dont know=2E
>>
>>=20
>> Correction: it's just !!!TRAILER!!!=2E
>
>We documented it as "TRAILER!!!" without leading !!!, and that its
>purpose is to
>flush hardlinks:
>
>https://www=2Ekernel=2Eorg/doc/Documentation/early-userspace/buffer-forma=
t=2Etxt
>
>That's what toybox cpio has been producing=2E Kernel consumes it just
>fine=2E Just
>checked busybox cpio and that's what they're producing as well=2E=2E=2E
>
>Rob

Yes, TRAILER!!! is correct=2E Somehow I managed to get it wrong twice=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
