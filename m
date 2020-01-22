Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052A71448DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 01:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAVAZX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 19:25:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53548 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgAVAZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:25:23 -0500
Received: from localhost (unknown [IPv6:2610:98:8005::647])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id ACEB8292E33;
        Wed, 22 Jan 2020 00:25:21 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
In-Reply-To: <20200120214046.f6uq7rlih7diqahz@pali> ("Pali =?utf-8?Q?Roh?=
 =?utf-8?Q?=C3=A1r=22's?= message of
        "Mon, 20 Jan 2020 22:40:46 +0100")
Organization: Collabora
References: <20200119221455.bac7dc55g56q2l4r@pali>
        <87sgkan57p.fsf@mail.parknet.co.jp>
        <20200120110438.ak7jpyy66clx5v6x@pali>
        <875zh6pc0f.fsf@mail.parknet.co.jp>
        <20200120214046.f6uq7rlih7diqahz@pali>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 21 Jan 2020 19:25:18 -0500
Message-ID: <85wo9knxqp.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Rohár <pali.rohar@gmail.com> writes:

> On Monday 20 January 2020 21:07:12 OGAWA Hirofumi wrote:
>> Pali Rohár <pali.rohar@gmail.com> writes:
>> 
>> >> To be perfect, the table would have to emulate what Windows use. It can
>> >> be unicode standard, or something other.
>> >
>> > Windows FAT32 implementation (fastfat.sys) is opensource. So it should
>> > be possible to inspect code and figure out how it is working.
>> >
>> > I will try to look at it.
>> 
>> I don't think the conversion library is not in fs driver though,
>> checking implement itself would be good.
>
> Ok, I did some research. It took me it longer as I thought as lot of
> stuff is undocumented and hard to find all relevant information.
>
> So... fastfat.sys is using ntos function RtlUpcaseUnicodeString() which
> takes UTF-16 string and returns upper case UTF-16 string. There is no
> mapping table in fastfat.sys driver itself.
>
> RtlUpcaseUnicodeString() is a ntos kernel function and after my research
> it seems that this function is using only conversion table stored in
> file l_intl.nls (from c:\windows\system32).
>
> Project wine describe this file as "unicode casing tables" and seems
> that it can parse this file format. Even more it distributes its own
> version of this file which looks like to be generated from official
> Unicode UnicodeData.txt via Perl script make_unicode (part of wine).
>
> So question is... how much is MS changing l_intl.nls file in their
> released Windows versions?
>
> I would try to decode what is format of that file l_intl.nls and try to
> compare data in it from some Windows versions.
>
> Can we reuse upper case mapping table from that file?

Regarding fs/unicode, we have some infrastructure to parse UCD files,
handle unicode versioning, and store the data in a more compact
structure.  See the mkutf8data script.

Right now, we only store the mapping of the code-point to the NFD + full
casefold, but it would be possible to extend the parsing script to store
the un-normalized uppercase version in the data structure.  So, if
l_intl.nls is generated from UnicodeData.txt, you might consider to
extend fs/unicode to store it.  We store the code-points in an optimized
format to decode utf-8, but the infrastructure is half way there
already.

-- 
Gabriel Krisman Bertazi
