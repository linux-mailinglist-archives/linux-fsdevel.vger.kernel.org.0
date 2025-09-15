Return-Path: <linux-fsdevel+bounces-61380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A09B57BB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5B944159B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D4430149A;
	Mon, 15 Sep 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9TtBfnj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AA2FB63D;
	Mon, 15 Sep 2025 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940381; cv=none; b=M4ZEwkxp/FzCdK0Ho16MD2K6PadckkWU+vJfa0VMYK8aB/bXcNY7ULPu0vPPloWT1X2SdNdM3SshBLxzi9V5JI6VjXAm5/ENMjLHwtnjO2oLEHPS5nWeuLs5bfGPL6VSr+Qr/BAq4BnRZPkfupFzi09ekjatH+arUs8gH76uGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940381; c=relaxed/simple;
	bh=F85ER++AIPFDQoXRw+FpsymYhshXa+B9MnUDCqC7GOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwIlEV+Gb+UVLBkklxp9fKL8uP52TCOv++C3kJ6mniC5Z1Pqa67i9BcbgLwTdWjPYk1FfrBJSHcJv4hLWgONCrItJdk2JHBipDApn13e4oqmsPxDipCdIHe5hpARg/OWy5VNlKtCdZLPZgVFv/zoHMT785nsuPU8po8nT8PqnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9TtBfnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E28AC4CEF1;
	Mon, 15 Sep 2025 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940381;
	bh=F85ER++AIPFDQoXRw+FpsymYhshXa+B9MnUDCqC7GOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9TtBfnjVsO4xdmRKEHL5/Vi/16WE7yZcvx+RPvyL3TQk6e2cqfwnV/WAQO/CbdqT
	 mIdHiK+lVOVGw4O2E+nx04bJg+kK8soBAh4YYi3I49H+W6PhoJB6+0xnLeevNF5sxq
	 TTIRZ9il2OjjHv4xl34P/9Kid6g3bk4bA8MziaaXemaF6EMt0EC49D2mwhV/946YUN
	 D1gd7ZmG0s6+T5uYyufChVQxOPZhEiIbfexR4UPMPRXb6YuRMOTfPztWRiB0KN+vJ6
	 q2Gck2KSmNNEVyMiiXrFbrY9bqlyCyNOBbDEC13l1PjAOuy3LThp+14g1dSbhXKQt9
	 CD0AENvFjfXUA==
Date: Mon, 15 Sep 2025 14:46:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	jack@suse.cz, neil@brown.name, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, linkinjeon@kernel.org
Subject: Re: [PATCH 5/6] generic_ci_validate_strict_name(): constify name
 argument
Message-ID: <20250915-baufahrzeuge-mietschulden-b21f7984ddb1@brauner>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
 <20250911050534.3116491-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911050534.3116491-5-viro@zeniv.linux.org.uk>

On Thu, Sep 11, 2025 at 06:05:33AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

