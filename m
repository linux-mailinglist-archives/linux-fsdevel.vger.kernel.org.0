Return-Path: <linux-fsdevel+bounces-59029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902FBB33F88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AB617324F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA5F1B87E8;
	Mon, 25 Aug 2025 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvSv09ID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3C2690D9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125203; cv=none; b=meUvveb9TDZScFCMFdaGUAnQex6Ec4IPEwuu1VOwm1MlmHTDLccX2Fc0vT01MRxjgmBUtwml/F6HXyODNQ1/+cHTjTNhIuJsa6OfuObOyjlx/0F+BVodM7MKF+wPiCidyYJhHONZI5xUfCEqM/N14f8zNBp8hnT6lIDxt2x7Ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125203; c=relaxed/simple;
	bh=Czoch4zmL+/G9ptPej6XIWeWQnDlu0rp0KZH6+qBsDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMnh+snnSpUiVd2AP2/Dybaqywxz1elwaLq1r48eUSTQFznz+sOElSYaywGsZY7Jsc4ks/hJWtSse3kvu0O2Rnu8Z38ENIaei+cdJfgl2O/5xyY62yR8yzfLzAm7CiBgN7lYZEInhAERUHnZEeWDNGMtlAz3H7v+18KQsFAxOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvSv09ID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2824C4CEED;
	Mon, 25 Aug 2025 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125202;
	bh=Czoch4zmL+/G9ptPej6XIWeWQnDlu0rp0KZH6+qBsDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvSv09IDfPbfU2exAp4j1YwxikjzgViqli/612faKgk89BGab755JJp6xdCfjYnlQ
	 ALoYYDLX8Lz8/JB7AuXY2oD1jVakYk0uZWb20lOSWxX0izWDhp7lCChVt8p2gGsDs0
	 Gl8lhykuaRVegRJcxorNCsW5Oj33E21lxYxgtElDGRCC2ZNzm27fMMO4+f4/EOus9F
	 SjlgTTMsUymdBCwEraT6BAtDpN3cBhT/X5gQBJeGsd13no0QP2BjQC5q4qzJSkDdIC
	 Iczrow7nutWU6N3vWhSHPkgywjSs8+PWS1vwzXXdNZyEdqqrmOX59xJqrWGHvGhZ0N
	 1/TleK/SJ7ouw==
Date: Mon, 25 Aug 2025 14:33:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 04/52] __detach_mounts(): use guards
Message-ID: <20250825-horrend-koffein-4cb509974a1c@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-4-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:07AM +0100, Al Viro wrote:
> Clean fit for guards use; guards can't be weaker due to umount_tree() calls.
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

