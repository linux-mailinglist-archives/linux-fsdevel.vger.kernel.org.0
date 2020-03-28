Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96E5196A14
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Mar 2020 00:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgC1XlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 19:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1XlB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 19:41:01 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 677EA20748;
        Sat, 28 Mar 2020 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585438860;
        bh=079x/adYayaXUe+4YHk2yhLPqwGm/hssdsj88iHVaPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/NzA/oaAuwwudo9NSRfHSLGvC8fLeDOxdW5/lREDdTZa1A3l2DE2Qx/E3RSNMQVe
         o5rm3fxRLtiYxJV0FohHU3WA4NhLUG8Z+wEu2Ob5+nfd6OnSjjhwHvUux5hAebWRs0
         LI54CzfOBS+uv/xXMhe3liwOhxis0oQ/SqPTLPnQ=
Received: by pali.im (Postfix)
        id 67DD07B5; Sun, 29 Mar 2020 00:40:57 +0100 (CET)
Date:   Sun, 29 Mar 2020 00:40:57 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Message-ID: <20200328234057.dh23w255eaag2glg@pali>
References: <20200317222555.29974-1-pali@kernel.org>
 <20200317222555.29974-2-pali@kernel.org>
 <20200318000925.GB23230@ZenIV.linux.org.uk>
 <20200318093251.bgxd3l5om4zlm3br@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318093251.bgxd3l5om4zlm3br@pali>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 18 March 2020 10:32:51 Pali Rohár wrote:
> On Wednesday 18 March 2020 00:09:25 Al Viro wrote:
> > On Tue, Mar 17, 2020 at 11:25:52PM +0100, Pali Rohár wrote:
> > > Function partial_name_hash() takes long type value into which can be stored
> > > one Unicode code point. Therefore conversion from UTF-32 to UTF-16 is not
> > > needed.
> > 
> > Hmm...  You might want to update the comment in stringhash.h...
> 
> Well, initially I have not looked at hashing functions deeply. Used
> hashing function in stringhash.h is defined as:
> 
> static inline unsigned long
> partial_name_hash(unsigned long c, unsigned long prevhash)
> {
> 	return (prevhash + (c << 4) + (c >> 4)) * 11;
> }
> 
> I guess it was designed for 8bit types, not for long (64bit types) and
> I'm not sure how effective it is even for 16bit types for which it is
> already used.
> 
> So question is, what should we do for either 21bit number (one Unicode
> code point = equivalent of UTF-32) or for sequence of 16bit numbers
> (UTF-16)?
> 
> Any opinion?

So what to do with that hashing function?

Anyway, "[PATCH 4/4] exfat: Fix discard support" should be reviewed as
currently discard support in exfat is broken.
