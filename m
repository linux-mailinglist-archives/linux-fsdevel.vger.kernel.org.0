Return-Path: <linux-fsdevel+bounces-22194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4272A91377C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 05:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF187B21713
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 03:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC86715AE0;
	Sun, 23 Jun 2024 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gXVx8wQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9664D;
	Sun, 23 Jun 2024 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719112299; cv=none; b=pNgjQG+8ZS3xa0we2GM6l84i6tarkZfV3uXovlfei9ncqgW2JQb2z4jFiy5g2xlKGe6bgaC63bGgswBWBh782SWyYUOh4TfMaNc/DDmP5m7yCdTmBzVu6fU+s67uHUojspXSFQxupDqTbScmOoowRRky0c3BsnoVpnK3kKo5uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719112299; c=relaxed/simple;
	bh=UXfVizu6Dw6SE/aiecqcyaAHLR9moIpdYiScLyrPSxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7MY4MxSVZq5MBSUccs/9zJs2y1FlPR0C9O8Et3RLcehXEAsa4hTNWDBL7bFlp/z5g6H0vRHRGT1BbMKEviy/L9bRIH2+t9pIQ36jpSCp4eZDMgZmxZazHhQN+KK9fBbWP2RmRSb9csKnAbhtmvHI20jTLsEswOaZaUhH025TmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gXVx8wQO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=y9uWSeBXGFFkTKzpeCZedo92XcBKtugbjarhe/W3XfE=; b=gXVx8wQODxcvu5+RNSe4JuP8dx
	8YiG5Llm57Kofa9LcDUF50LviqbVQzF3RV/awxWZw3StuN4cblmBdraMszSMKhHYgo8cO22aBvBp/
	h8mbYDVzId4UL+Svlf+mV2XV5MBhLZC8ubx/yBcXGFp4e4uG1U+o70EKPrhti73Djzw7Ot1yur4Ya
	IWnDexW2JlS2AUlNYplSpJqG5twbYdclTTbJIu08AmIt37T3KYHrtiUMsKdxo26LwZmX4JhGtxGrT
	COledEBuTIjN8iUsEFVTQxiFX4ODRTnxF5NCfzVUnBw35s1gKe7cC24wLu48oGlWKYySg7vA4zgBk
	QclIweFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLDdQ-00000008lfC-1wDX;
	Sun, 23 Jun 2024 03:11:20 +0000
Date: Sun, 23 Jun 2024 04:11:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com,
	alexei.starovoitov@gmail.com, rostedt@goodmis.org,
	catalin.marinas@arm.com, akpm@linux-foundation.org,
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 06/11] mm/util: Deduplicate code in
 {kstrdup,kstrndup,kmemdup_nul}
Message-ID: <ZneSWDgijj3r0MMC@casper.infradead.org>
References: <20240621022959.9124-1-laoar.shao@gmail.com>
 <20240621022959.9124-7-laoar.shao@gmail.com>
 <ZnWGsw4d9aq5mY0S@casper.infradead.org>
 <CALOAHbC0ta-g2pcWqsL6sVVigthedN04y8_tH-cS9TuDGEBsEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbC0ta-g2pcWqsL6sVVigthedN04y8_tH-cS9TuDGEBsEg@mail.gmail.com>

On Sun, Jun 23, 2024 at 10:29:30AM +0800, Yafang Shao wrote:
> On Fri, Jun 21, 2024 at 9:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jun 21, 2024 at 10:29:54AM +0800, Yafang Shao wrote:
> > > +++ b/mm/internal.h
> >
> > Why are you putting __kstrndup in a header file when it's only used
> > in util.c?
> 
> I want to make it always inlined. However, it is not recommended to
> define an inline function in a .c file, right ?

I'm not aware of any such recommendation.  Better than putting it in
a .h file that everybody has to look at but nobody uses.


