Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC106142A0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 13:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATMHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 07:07:17 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:52522 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATMHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:07:17 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 5745215CBE2;
        Mon, 20 Jan 2020 21:07:16 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-16) with ESMTPS id 00KC7Fw9037236
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 21:07:16 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-16) with ESMTPS id 00KC7Ebd227995
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 21:07:14 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 00KC7CGW227993;
        Mon, 20 Jan 2020 21:07:12 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
References: <20200119221455.bac7dc55g56q2l4r@pali>
        <87sgkan57p.fsf@mail.parknet.co.jp>
        <20200120110438.ak7jpyy66clx5v6x@pali>
Date:   Mon, 20 Jan 2020 21:07:12 +0900
In-Reply-To: <20200120110438.ak7jpyy66clx5v6x@pali> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message of
        "Mon, 20 Jan 2020 12:04:38 +0100")
Message-ID: <875zh6pc0f.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Rohár <pali.rohar@gmail.com> writes:

>> To be perfect, the table would have to emulate what Windows use. It can
>> be unicode standard, or something other.
>
> Windows FAT32 implementation (fastfat.sys) is opensource. So it should
> be possible to inspect code and figure out how it is working.
>
> I will try to look at it.

I don't think the conversion library is not in fs driver though,
checking implement itself would be good.

>> And other fs can use different what Windows use.
>> 
>> So the table would have to be switchable in perfect world (if there is
>> no consensus to use 1 table).  If we use switchable table, I think it
>> would be better to put in userspace, and loadable like firmware data.
>> 
>> Well, so then it would not be simple work (especially, to be perfect).
>
> Switchable table is not really simple and I think as a first step would
> be enough to have one (hardcoded) table for UTF-8. Like we have for all
> other encodings.

Ignoring if utf8 table is good or not.  If the table is not windows
compatible or doesn't satisfy other fs's requirement, it also is yet
another broken table like now (of course, it would likely be better
off).  Of course, we can define it as linux implementation limitation
though.

So yes, I think this work is not simple.

>> Also, not directly same issue though. There is related issue for
>> case-insensitive. Even if we use some sort of internal wide char
>> (e.g. in nls, 16bits), dcache is holding name in user's encode
>> (e.g. utf8). So inefficient to convert cached name to wide char for each
>> access.
>
> Yes, this is truth. But this conversion is already doing exFAT
> implementation. I think we do not have other choice if we want Windows
> compatible implementation.

For example, we can cache the both of display name, and upper/lower case
name. Anyway, at least, there are some implement options.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
