Return-Path: <linux-fsdevel+bounces-24607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5B6941318
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0421B1F233A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2669F19FA87;
	Tue, 30 Jul 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UilyB9X3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146555769;
	Tue, 30 Jul 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345991; cv=none; b=O4co3dQVyCckU6FMpONYGQUf1RIDLIyuxFNrcjTRWjLmaOvkQNdaaNoEWXP7iEtogsZTDwmXCER4qnKxa4rLhcYJsvy5cPiPCd5G1N7S5Zl7LOXuOioAVAAn7Jp7Gwyuku2rPw3KhZRx/akCejzZD3J55p+xnmYmCoYtWK4vhMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345991; c=relaxed/simple;
	bh=HISM98Ay0WWuaHogvlPHXl5HPQkpYwN2KJ1ekwInS4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVhKrKfz+urO7piX7/XmBoqmO9JagCQnXA0EvGqZl+9pgVlJQQFtknbVRQ9BbTBXDOfy0BmHwByCjgNRnbPJQO9682viVzG30beLjK2FQ0XjoTmltGD2e5rE7S1JgO44JwMJDE8/6fWjQPWg/NSutvlXscFiogpJNI6/ueLanLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UilyB9X3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jDlk0/3hMO7Vd0hLRG4kBbSvr6LqrzTNupwmh7CFwFY=; b=UilyB9X3mn/Ehep0vjEwe0KCo3
	VmnqZ/RsEq2OBza3MIW0xB1GDIaDT3YY5j51wp2cydwSeNljEVQ9/tVZ9nMWVoiLSk4P5NUJs+Rje
	C4ju+6rfO8Z5ms6rOLiRSTlvzxVJn0/8Kmee/KSO+hRaWVlxISO45O9MPfYrKZZksqbIQjmH70rgJ
	3E3aSHaXlEtrbRnf7+JPr8S5SOeiGLt2LnKTvbkahOCknBnA+/diDboTpMrrnwo9FXwIN4Y9FEoOR
	tYd+9tHVgjbGgqjquJ4DEKTKbFruox78tanhNvj/z09d3nerbuKg2PccvonGoPmdVdMkEq5hkTXKa
	0gu/SQag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYmrz-0000000EjCS-2rvP;
	Tue, 30 Jul 2024 13:26:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 034513003EA; Tue, 30 Jul 2024 15:26:27 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:26:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
	tglx@linutronix.de
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240730132626.GV26599@noisy.programming.kicks-ass.net>
References: <20240730033849.GH6352@frogsfrogsfrogs>
 <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>

On Tue, Jul 30, 2024 at 01:00:02PM +0530, Chandan Babu R wrote:
> On Mon, Jul 29, 2024 at 08:38:49 PM -0700, Darrick J. Wong wrote:
> > Hi everyone,
> >
> > I got the following splat on 6.11-rc1 when I tried to QA xfs online
> > fsck.  Does this ring a bell for anyone?  I'll try bisecting in the
> > morning to see if I can find the culprit.
> 
> xfs/566 on v6.11-rc1 would consistently cause the oops mentioned below.
> However, I was able to get xfs/566 to successfully execute for five times on a
> v6.11-rc1 kernel with the following commits reverted,
> 
> 83ab38ef0a0b2407d43af9575bb32333fdd74fb2
> 695ef796467ed228b60f1915995e390aea3d85c6
> 9bc2ff871f00437ad2f10c1eceff51aaa72b478f
> 
> Reinstating commit 83ab38ef0a0b2407d43af9575bb32333fdd74fb2 causes the kernel
> to oops once again.

Durr, does this help?


diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 4ad5ed8adf96..57f70dfa1f3d 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -236,7 +236,7 @@ void static_key_disable_cpuslocked(struct static_key *key)
 	}
 
 	jump_label_lock();
-	if (atomic_cmpxchg(&key->enabled, 1, 0))
+	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
 		jump_label_update(key);
 	jump_label_unlock();
 }

