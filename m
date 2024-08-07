Return-Path: <linux-fsdevel+bounces-25259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F7094A54A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7546A28357B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789631DD3B5;
	Wed,  7 Aug 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVrexHsk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB71803A;
	Wed,  7 Aug 2024 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026203; cv=none; b=EIpZDnDBAHGBbNlOK8akiBBxS+nJiaEBOyUD06ansZg1wnGGijU2aEPpknZzH0R7PKjtWhLDtpbv8fwLaLArEnWGjoYHlDt9IY6qtW+ztfnSyjgJ6zahmXaZFZqIpia3g/jU/oammV4BpwceBjvqkiPfsZ8+V7HaNf/9s5ocEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026203; c=relaxed/simple;
	bh=DN/7Kag72g7FaNidtmN/v8paJJdJ6G1PIHJ8z7NPSTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skeP6TH+TcYU+FDQvMf0fhgxSFm1xpiFTsYfGfSHJnPLAn4eHA06u7RQ2iYREi+PNRdq5oWd3nvWH6rKOL9T68f5HntnQ8tTsMsRpeC/HpUkLtPS9spN0xbhXzDRUBIcIjkRAMXHJ+8LeM+zMvqASpjjfX7qYVXqzl6ZlxBt4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVrexHsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CBDC32782;
	Wed,  7 Aug 2024 10:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026203;
	bh=DN/7Kag72g7FaNidtmN/v8paJJdJ6G1PIHJ8z7NPSTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVrexHskepkcm5QVFYzSuwDJtxkx0inW5YvKf3pIyXYWzqnf6Am2in5vPYUu5xG30
	 53fu1Iu+7IAjvUaamLW6YdMNhpqm50N/yS9tEx+2aJNfWwCH9k9MDaRBkNyWrCIqxH
	 4Qkt+KTK3EapDHVCf/ERPiIxjkGp8fiyLV9YY8h7vu3ebNzyGGcvp5/HKIHBTGS3R7
	 MNoLx9neFwS/MZwa7NGQ0hh3hvVSuz2jZyM+ncse/jmwietSOQPGcI1iOTYhw87xhY
	 h2dzzwUqk4h9swuQEUl1qilMggCcff6ZBt+JcEgjdh95yK3sc5X+hzEzZ2Sh3XN2I5
	 mJ/FLJP25sVOA==
Date: Wed, 7 Aug 2024 12:23:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 08/39] experimental: convert fs/overlayfs/file.c to
 CLASS(...)
Message-ID: <20240807-kundschaft-bauhof-fea71dc229dd@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-8-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-8-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:54AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> There are four places where we end up adding an extra scope
> covering just the range from constructor to destructor;
> not sure if that's the best way to handle that.

I think it's fine and not worth obsessing about it.
Reviewed-by: Christian Brauner <brauner@kernel.org>

