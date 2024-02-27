Return-Path: <linux-fsdevel+bounces-13017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D44486A2E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF7AB2371E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 22:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5455C32;
	Tue, 27 Feb 2024 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvdAu2EK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B855C20
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 22:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074773; cv=none; b=tkegoNCjFs+AwOpuzoGRRKJ0YrJWN/+Ilh/RL6jPj9WLEA1kt97snVhkOeFzEXrPBRvMq28oOVeLVBgaTTMQih9uXiPLyw1QhjIzIflFXtnOPIL1r76Ne1P2mGz022Eq/5hK2i7U4kC3MBorStTRiXEfsHOIKb5QgrnWA0XQeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074773; c=relaxed/simple;
	bh=n44o2P9eUJ3GX7KHobx/cGPdlYo0il4D2KzMhZAw3Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxH+3PEDQY2KyMTiHXjmx4OX2ueKvbTAIXXgbug1J3sE1URcIBzqYuruDwF3P4QhvvuK/V9/RiukaqEWF+pAx2rDuoV7ffaqZt9rvLhD30A6LWRL7fw6uWQD7xUrnMx1UxAopUOtKLWxJ/4cxcqrcI0vwxD3EXe5t+3npmG8ja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvdAu2EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59385C433F1;
	Tue, 27 Feb 2024 22:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709074773;
	bh=n44o2P9eUJ3GX7KHobx/cGPdlYo0il4D2KzMhZAw3Bs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GvdAu2EKFTp/GiGMLKKioJI0itJ4Di9Dvbp0Pdo5tSrOdV2maxq4D4USNPZHX5hwe
	 F2cwU/ZC3HlnCFNE6NWM+6YgNCKc+tIHB+oFqcrhJws+vkWS0RMBuFk908L540ckRh
	 Lc3niueWigpJs0bO+wNYf78hjowAmvgSbZoDYICj+ByCvlS7EXdq0Do0M7HBcYb6hI
	 Pa5zBKZZin2nM/V+oEBJYlHgcvoPQqehkiC4JtVA4dWi8Z9PkPY6chaNWkY5a7mwAT
	 Z5uFNDbS4L6cPJP8uJDtw6bl8+V2YY7OxEhOqLbsmKGy0bDFD2qn1G2QjwDG1WYfEi
	 P9UZJBFeY0LsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 09CF3CE0D32; Tue, 27 Feb 2024 14:59:33 -0800 (PST)
Date: Tue, 27 Feb 2024 14:59:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <d4cc365a-6217-4c99-a055-2a0bf34350dc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>

On Tue, Feb 27, 2024 at 09:19:47PM +0200, Amir Goldstein wrote:
> On Tue, Feb 27, 2024 at 8:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello!
> >
> > Recent discussions [1] suggest that greater mutual understanding between
> > memory reclaim on the one hand and RCU on the other might be in order.
> >
> > One possibility would be an open discussion.  If it would help, I would
> > be happy to describe how RCU reacts and responds to heavy load, along with
> > some ways that RCU's reactions and responses could be enhanced if needed.
> 
> Adding fsdevel as this should probably be a cross track session.

The more, the merrier!  ;-)

							Thanx, Paul

