Return-Path: <linux-fsdevel+bounces-2629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7857E725F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 20:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DEC7B20D59
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AD836B0E;
	Thu,  9 Nov 2023 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J+aegCts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A40358A4
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 19:32:36 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4823ABA
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 11:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IgKWjK1z22x8Mu0x/0FZS8WV0GynvXIqfAzNZgGiH2I=; b=J+aegCtsGro6bD2WUTChGdNT+x
	V6Pisqlsp1K/jjzBSfaJvW3H7h2kEHJNxcwpK6P16ZEJ5NIKSv9zYe1/OGMOagxlGwC1lF+zuulzO
	G0lvgul5MlrAfbtqJkjgfH9s/P3mvP5VIliLh6J/PaHBOnHuHwqd/RbSWat4TQ+r0VFlMlSLEy/1Y
	RjzF1lRJaaYEM2JeO9HMxPxQvbfZbxNK2oEOVJTaksrYibiwWalYqkDbySTMzugSA1p5Br3fOlMbZ
	G8Za789SmQRFTzXQUGgYbCEjxEgvH3dlZY3gEj01y+QUBlIwkEMqRtg5EcaCQT+sgHRwSk+19phA9
	EhQ1is6A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1AlV-00DYsu-1f;
	Thu, 09 Nov 2023 19:32:33 +0000
Date: Thu, 9 Nov 2023 19:32:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/22] dentry: switch the lists of children to hlist
Message-ID: <20231109193233.GC1957730@ZenIV>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-4-viro@zeniv.linux.org.uk>
 <20231109-ausnehmen-machen-dbeafa47e9e6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-ausnehmen-machen-dbeafa47e9e6@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 02:48:19PM +0100, Christian Brauner wrote:
> On Thu, Nov 09, 2023 at 06:20:38AM +0000, Al Viro wrote:
> > Saves a pointer per struct dentry and actually makes the things less
> 
> Which you're giving back to DNAME_INLINE_LEN.

Have to - we want the size to stay a multiple of 64.  So DNAME_INLINE_LEN serves
as a sump - any space savings we get go in there, just as any additional fields
have to pull the space out of there.

FWIW, from distribution of name lengths on 3 local boxen, with reasonably diverse
contents of filesystems:

< 24: 90.6877% 89.8033% 89.3202%
< 25: 92.2120% 90.4324% 90.4652%
< 26: 93.5858% 95.0555% 92.3849%
< 27: 94.6277% 95.4424% 93.1948%
< 28: 95.4827% 95.7796% 93.9134%
< 29: 96.1926% 96.0851% 94.5449%
< 30: 96.7963% 96.3503% 95.1006%
< 32: 97.6930% 96.5792% 95.5681%
< 33: 98.0392% 96.7943% 95.9879%
< 34: 98.3134% 96.9829% 96.3353%
< 35: 98.5493% 97.1352% 96.6313%
< 36: 98.7468% 97.2757% 96.8890%
< 37: 98.9134% 97.4192% 97.1199%
< 38: 99.0515% 97.5506% 97.3372%
< 39: 99.3650% 97.6394% 97.4857%
< 40: 99.4606% 98.8016% 97.7237%

So 32 is tolerable, but going down would rapidly become unpleasant.  This series
does not introduce any new fields, but it's nice to be able to do so without
causing PITA for long names.

