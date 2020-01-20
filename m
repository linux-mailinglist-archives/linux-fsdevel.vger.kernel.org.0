Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F6142980
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 12:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgATLbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 06:31:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:51644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgATLbS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:31:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ABDD1AD81;
        Mon, 20 Jan 2020 11:31:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 62AFB1E0CF1; Mon, 20 Jan 2020 12:31:16 +0100 (CET)
Date:   Mon, 20 Jan 2020 12:31:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: udf: Incorrect handling of timezone
Message-ID: <20200120113116.GC19861@quack2.suse.cz>
References: <20200119124944.lf4vsqhwwbrxyibk@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200119124944.lf4vsqhwwbrxyibk@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 19-01-20 13:49:44, Pali Rohár wrote:
> Hello! I looked at udf code which converts linux time to UDF time and I
> found out that conversion of timezone is incorrect.
> 
> Relevant code from udf_time_to_disk_stamp() function:
> 
> 	int16_t offset;
> 
> 	offset = -sys_tz.tz_minuteswest;
> 
> 	dest->typeAndTimezone = cpu_to_le16(0x1000 | (offset & 0x0FFF));
> 
> UDF 2.60 2.1.4.1 Uint16 TypeAndTimezone; says:
> 
>   For the following descriptions Type refers to the most significant 4 bits of this
>   field, and TimeZone refers to the least significant 12 bits of this field, which is
>   interpreted as a signed 12-bit number in two’s complement form.
> 
>   TimeZone ... If this field contains -2047 then the time zone has not been specified.
> 
> As offset is of signed 16bit integer, (offset & 0x0FFF) result always
> clears sign bit and therefore timezone is stored to UDF fs incorrectly.

I don't think the code is actually wrong. Two's complement has a nice
properly that changing type width can be done just by masking - as an
example -21 in s32 is 0xffffffeb, if you reduce to just 12-bits, you get
0xfeb which is still proper two's complement encoding of -21 for 12-bit wide
numbers.

> This needs to be fixed, sign bit from tz_minuteswest needs to be
> propagated to 12th bit in typeAndTimezone member.
> 
> Also tz_minuteswest is of int type, so conversion to int16_t (or more
> precisely int12_t) can be truncated. So this needs to be handled too.

tz_minuteswest is limited to +-15 hours (i.e., 900 minutes) so we shouldn't
need to handle truncating explicitely.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
