Return-Path: <linux-fsdevel+bounces-10497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEB984BA99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAB11F225FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EFE134CCA;
	Tue,  6 Feb 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wptko6c5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844A132C38;
	Tue,  6 Feb 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235701; cv=none; b=TJy4CvgFDk3IxqQdhhdhUNCoQjljnzCUrKLTSfHEbEeO+LH1JDwY9DLrbdF4HGUuyX4NmGVTasbN+cuYMfGOHpBSnM/gNf+bvHNEA+yY27qN8+IwwD5FVqYMyNQzYx+AfCOaYi8aHdkxecgwZde6FP4WpuUKwkGDKbqEz/iZY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235701; c=relaxed/simple;
	bh=xx+uet01JmCi1ViMt/Dsv2EQrSufqPhQXOOo6idXflo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHQop1Wtjgqi6Z7c2QnDlh2LQQ6QdCZO6m18pfxGZAgj4mHvMYyYmFOSB1cBoCUWvFOPZJAc2VcsQLWR6CsIyCSmMwdLWu9cp5alH/82QpqSs/N7NkvLLpGz24DO2tw6nRlz3F39n6Olh4N3lYq+bXbbCjEeQP4/20SNGaPX0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wptko6c5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25604C433C7;
	Tue,  6 Feb 2024 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707235701;
	bh=xx+uet01JmCi1ViMt/Dsv2EQrSufqPhQXOOo6idXflo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wptko6c5pla1dHBdR2lalwpdwsIjtFk/kVtiTj2lkfWPX0coMf1iOEn98FfP3kEqR
	 IiXP9GC9zIUW6rrxTfJqbnshArcElbLMgSnblJisMDNuz/dPfbJ7Iaefkj5pSMtNGM
	 FhGT8aOjf1SuXK5oLGVJjrKOeGWPrhHOgWIw0D3zI5D2IvHUzEcQwUDMcehbRZB4Za
	 R2eqjutyQC1ockeANwd+MhtRbJZ0osbO01uS1dLK9r+RzRtWyg7Nwxl++kip/VgR2W
	 vjvSXbrTiOhO+7Uxi3c391HmSee+fR4Q6U6uVTKTRlL7Gj/Zz0Qg5+HJht5njmVlU5
	 xJcuYs/2xdFig==
Date: Tue, 6 Feb 2024 17:08:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [remap_range] dfad37051a:
 stress-ng.file-ioctl.ops_per_sec -11.2% regression
Message-ID: <20240206-sumpf-lunge-fdf63a8bf77c@brauner>
References: <202401312229.eddeb9a6-oliver.sang@intel.com>
 <CAOQ4uxiwCGxBBbz3Edsu-aeJbNzh5b-+gvTHwtBFnCvbto2v-g@mail.gmail.com>
 <CAOQ4uxgAaApTVxxPLKH69PMP-5My=1vS_c6TGqvV5MizMKoaiw@mail.gmail.com>
 <Zb8vk1Psust0ODrs@xsang-OptiPlex-9020>
 <CAOQ4uxjFA=P8ZiPjaqP-4Ka35GdqEtKaTTG1XMnts6rOswchCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjFA=P8ZiPjaqP-4Ka35GdqEtKaTTG1XMnts6rOswchCA@mail.gmail.com>

> Christian, can you please amend the fix commit to
> Reported-and-tested-by: kernel test robot <oliver.sang@intel.com>

Ok, done.

