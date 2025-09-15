Return-Path: <linux-fsdevel+bounces-61379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8400CB57BB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5842204AAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C65F30EF92;
	Mon, 15 Sep 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPSRKrQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E141330EF80;
	Mon, 15 Sep 2025 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940366; cv=none; b=e4r1JjybEJ27ZVjDq/aymqzUXETUf0FVkDuzn2ZfzK7wbWBX4EL4fViLcaxelRjlBYi4LfhWmu21xhlhsw0G/OmaXzgvw+LlSHd8fQUA+ttuGZAQ3JTUmb6P+3l5bJPTmgRZP+XvD2rNIz7opoIEXBmb8larED2Iu16c18fKQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940366; c=relaxed/simple;
	bh=dcc95MdN/axaJ4GFZKoheBHP2cvfrr6JtSrBoktK0ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOkUnnbOSzjPsSIKlDM1mxplC5A6lpQMpIrHD0186NlEbPftiVkJyQ0YZTTQtkydj/RYWWz0Zw5ceRi543/5JTUmVwDfA4JEYy23XWYcV6w8/8cVJni3MuY5lizDIDyiKdfUOBeD8LPZNqfrKukSB7MRkzd1U1VQv6/sN1RLfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPSRKrQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F2DC4CEFE;
	Mon, 15 Sep 2025 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940365;
	bh=dcc95MdN/axaJ4GFZKoheBHP2cvfrr6JtSrBoktK0ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPSRKrQcty08RxXY7QqmPYcyOTbmsveCtheS94zbcI0cODjuw/qVuRzP1vymAb0Cx
	 Nd2ZCkUcPM46HCrdCg+WxS20+2+0mRtuUMi34qlg5U3GSdlt9cOkWiwDFVRxdPpSjK
	 0Th4OuCmlCJAbAupVN0a1sT+kKIXIhZw38e/s0/L+ZVZwS3FLNku0e7ocCXbiO+j0m
	 Og1Ho48K0ooNSkGwPPszX/c95+S8wtSYe0WwIXXQUlyRiAQk1455Z7Go6mbKqdXfaj
	 g/EN+WLrIbPovHkxz9n6JYO6s9bxAuPCyfXmBZu/+TOUULdUwFHqYm3PhpvLTVZKxa
	 U6FGFoMWwmsbw==
Date: Mon, 15 Sep 2025 14:46:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	jack@suse.cz, neil@brown.name, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, linkinjeon@kernel.org
Subject: Re: [PATCH 4/6] afs_dir_search: constify qstr argument
Message-ID: <20250915-berggipfel-chatten-c03aaddbbc3f@brauner>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
 <20250911050534.3116491-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911050534.3116491-4-viro@zeniv.linux.org.uk>

On Thu, Sep 11, 2025 at 06:05:32AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

