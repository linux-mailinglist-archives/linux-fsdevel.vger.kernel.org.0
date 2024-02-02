Return-Path: <linux-fsdevel+bounces-9955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D210184669F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 04:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7629BB223B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 03:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662B5E55E;
	Fri,  2 Feb 2024 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DMWQ5eFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22FD514;
	Fri,  2 Feb 2024 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706845775; cv=none; b=dHn1H08TqHLwDvCEskSJnBnmfIWjWqDhZlVLOCbtFTIXKIMjUj179t0TPdeB54xKU/0R3p/Eb00zx45VQBU9aDuS9rMwsiwKnk1TcGBHWfQRAQewSebImTmsM7RPUlAlpZrO3zzlCAtL7XoimhYuS8A6IelAsgBnATeZ5eG+k1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706845775; c=relaxed/simple;
	bh=Cv0w8oHTl4+0Yk8RFWfy1a7sSAUtwxQAmimPK9LrkYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erYsDHAqyQxoiAXVerxmM6jdxAGOza/AycLFPbP+XgnajxGXM1qHf4cb0oGsYFO8YKiR0Mk7wX8pXX5yBNvrykxg27tflDnBEebCQ5rRPn+ocNrlIAUUZPvBE0UUcaXRqe2gvz4NHEHxXuMFs0Peqjwft/2fx5lpGzVKr3RQTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DMWQ5eFU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MqQmRHXIGwvjNURHDffefpzXQRpdMsIdEY9A7rDu3qU=; b=DMWQ5eFUmYBozpEalenAa7mNXn
	+rWG79SC5S0FeBh7O+UjZsQpnoXvJCVVBhLw+6zi08WhASm4qSZrEBZJx/Vut++peShGggpN2wkbo
	TgIR+v7RncUizi5tKF1JMv1RHjABhvUhIfS07mcAJidcebQ2/Mz52bNasIXlhneFX/WRJQDltkEwX
	fDY5uplHT3Cdm27B9udXGf2iMRomH587+Cj+nMtZtqeoJ84zJDVK/XCsnZYBfgkVXp7X5uBWFzBKc
	y9huFBvzYq/oDfgjKyqdBFwezCFr/HwXNn+eLZUn0TLVOLFQvWNOnWAB+YDrY1qZVQ5bKxNzS4fgt
	97mdp1ig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVkYP-003dd3-0Z;
	Fri, 02 Feb 2024 03:49:25 +0000
Date: Fri, 2 Feb 2024 03:49:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Doug Anderson <dianders@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
Message-ID: <20240202034925.GW2087318@ZenIV>
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV>
 <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV>
 <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 01, 2024 at 07:15:48PM -0800, Doug Anderson wrote:
> >
> > Well, the next step would be to see which regset it is - if you
> > see that kind of allocation, print regset->n, regset->size and
> > regset->core_note_type.
> 
> Of course! Here are the big ones:
> 
> [   45.875574] DOUG: Allocating 279584 bytes, n=17474, size=16,
> core_note_type=1029

0x405, NT_ARM_SVE
        [REGSET_SVE] = { /* Scalable Vector Extension */
                .core_note_type = NT_ARM_SVE,
                .n = DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_SVE),
                                  SVE_VQ_BYTES),
                .size = SVE_VQ_BYTES,

IDGI.  Wasn't SVE up to 32 * 2Kbit, i.e. 8Kbyte max?  Any ARM folks around?
Sure, I understand that it's variable-sized and we want to allocate enough
for the worst case, but can we really get about 280Kb there?  Context switches
would be really unpleasant on such boxen...

> [   45.884809] DOUG: Allocating 8768 bytes, n=548, size=16, core_note_type=1035
> [   45.893958] DOUG: Allocating 65552 bytes, n=4097, size=16,
> core_note_type=1036

0x40c, NT_ARM_ZA.
                /*
                 * ZA is a single register but it's variably sized and
                 * the ptrace core requires that the size of any data
                 * be an exact multiple of the configured register
                 * size so report as though we had SVE_VQ_BYTES
                 * registers. These values aren't exposed to
                 * userspace.
                 */
                .n = DIV_ROUND_UP(ZA_PT_SIZE(SME_VQ_MAX), SVE_VQ_BYTES),
                .size = SVE_VQ_BYTES,

