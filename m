Return-Path: <linux-fsdevel+bounces-41364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E806A2E3DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F4C166B05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D221E191F79;
	Mon, 10 Feb 2025 05:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nALuQFsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1789F13AD3F;
	Mon, 10 Feb 2025 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167143; cv=none; b=Dxmb+u0bEl8Cs7meBSEzwuEWQuz0zn4Xgn4pRlifiiii1AFRykN8eoz7UVg8+o6BW/vNLYwhj6Zo1I6tE2xX817uX8LNQZUQXjEPF7srk0y4lFHRJNiN17wY5D0aceHgLlENWj2+PDq+8usEINrydt7vSVT72Uml/IFrIqlFENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167143; c=relaxed/simple;
	bh=b2a3gJg8r8XY47Xb30aNYxU05tTtZlUoIqy5iyha99Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpu+qTW4Qe9oWwROlYQqFevg5pVtkP3hRXWiCmNj2ORwjXMVMIS00kUAtLqqtam4yLb8Ecixb378mS+QzDWadIJaUCydgrsCx62WpNAYmjmC4yBawMXevjf6ZlsLASd6wJOCfG1SWO1o7naYSNwABh0Miy/5sOLvT+u8Sy3AiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nALuQFsy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+T5uj758NieMk8bBUK5X8Wsdb6Nz4WNL4skk6Wb/mi4=; b=nALuQFsynagrv6fdtkvbOEi4wa
	xFxu2dPfwpgnwwMcQNlyukAW6+Xmm2edOvse2IkiZrEh+skoNl5E6ITA7JwK1AdUIO0IvPHxJu3U0
	k/t6IwZ8nlaY1b83Ed9LmmwU6ca8u12pyAXAzJSbn/i53MRbl8pmqn5pG03auGLywnowpaYHJP4n/
	Qz/MPwT1qfoPrYfk0loWgztK8k8BAyNcCAb3Vr3nolBU4cJ0PMUDo/jYh4qYb8VbnBh9ISg87/YZg
	tKO9rRSOg+PJTGUX5RHFoEU9hqNYM20BBd9vV9eVeawcq+Aa8mA9KnnIXJW2IJxFKDX7DxRmEc5Kp
	9/42VFuw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thMos-000000094nn-0SYO;
	Mon, 10 Feb 2025 05:58:58 +0000
Date: Mon, 10 Feb 2025 05:58:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Reaver <me@davidreaver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] debugfs: Replace debugfs_node #define with
 struct wrapping dentry
Message-ID: <20250210055858.GA1977892@ZenIV>
References: <20250210052039.144513-1-me@davidreaver.com>
 <20250210052039.144513-7-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210052039.144513-7-me@davidreaver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 09, 2025 at 09:20:26PM -0800, David Reaver wrote:

> +static inline struct debugfs_node *dentry_to_node(struct dentry *dentry)
> +{
> +	return container_of(dentry, struct debugfs_node, dentry);
> +}

No.  And you don't have any fields left in struct dentry to replace
that with following a pointer.

Again, do not embed struct dentry into any other object; you are not just
doing that on temporary basis, it's left in that form by the end of the
series.  No go.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

