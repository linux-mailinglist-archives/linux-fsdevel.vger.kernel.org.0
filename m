Return-Path: <linux-fsdevel+bounces-67891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC5C4CED7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E67A14FE808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C123337106;
	Tue, 11 Nov 2025 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MW8BXQRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA343358B7;
	Tue, 11 Nov 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855282; cv=none; b=XJjzI1RqBkkm8E5Rorb1T4crJIipo9mqlqAqwnt1RE/YLPc1wB/dVseLqZWwiob+B3GhiVGk/F0BSlI9m8XXVpQepccvGYJdgUm5u3zumKqHQQwvT17B0K4MDGsjdndvA/On57eF8ezkbV6/Yi19HXLzbVgd7TD+9VyKTgu3X/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855282; c=relaxed/simple;
	bh=wKBkphm/u5H9VukG6SiMiDP7RhdDvCoVHHzcrQaeABo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjy+Pv2di7LTiTBOB+sPAM9Ah8D8B/MuKnXs0wRuiC1dBN8/bU2I9vQ6asuZv3rgagkaVyqWbg1xziHzBKV/38hwA0SO4lWG7XWvfEngTmyVLnM0sqK44DS2DSSGFo6rVp+145byOYfNlExVTXRrUPy/CHs0zXHHtksCqOsya6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MW8BXQRZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mqzMG8DZM/gvRBtNitIiPBI41Lv4Ew10vO1gkoA+Kjs=; b=MW8BXQRZWfQCxSkVRaAW5RDNRv
	u1sda6MVQC9abOrzArDC8Tn/TJ0Lsnq3zSEIToxqDk+2Y3hn7b+eNYfnCIbwUlXCj2iIT2wjI/wew
	cBCjS6trY0nXW2EHN2fegFgCawQAJsMgikqLavler34mWIP1rQcTnw8A+1GdCExcvRmhNRc8KvMsv
	1qNOJzokl6uVp9Ybw0BL5rIhQ4k24h8BTs3yqMPybTjBAdjdlfD5wcYREFELha7wTjdS7t/GfB0pT
	gJRegxPM88TCv3SWy/DpaceAnnpzuoH08amxqHgXkDEMvxRFnhOFsiApuvBrXKnLF1ZZDYsq8fPYB
	xbQFpQFQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIlBb-0000000FeCe-2SRQ;
	Tue, 11 Nov 2025 10:01:15 +0000
Date: Tue, 11 Nov 2025 10:01:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v3 36/50] functionfs: switch to simple_remove_by_name()
Message-ID: <20251111100115.GU2441659@ZenIV>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <20251111-verelendung-unpolitisch-1bdcd153611e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-verelendung-unpolitisch-1bdcd153611e@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 11, 2025 at 10:30:22AM +0100, Christian Brauner wrote:

> > Incorrect.  The loop in question is
> 
> Are you aware that you're replying to a bot-generated email?

I am.  I couldn't care less about the bot, but there are intelligent
readers and the loop _is_ unidiomatic enough to trigger a WTF
reaction in those as well.  Sure, they can figure it out on their
own, but...

And yes, catching places that might smell fishy is one area where that
kind of bots can be genuinely useful - triage assistance, same as with
sparse/cc/etc. warnings.  With the same need to LART the cretins of
"The Most Holy Tool Makes Unhappy Noises - Must Appease It" variety,
of course...

