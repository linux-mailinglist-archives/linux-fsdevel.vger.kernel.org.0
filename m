Return-Path: <linux-fsdevel+bounces-35787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA5A9D853F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 13:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700CB1683CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8624719995A;
	Mon, 25 Nov 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/fnt1gz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CC41547C3;
	Mon, 25 Nov 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537059; cv=none; b=pa2XoPm+cZkPY6Umq2mj9Rfj6ddD2VNLWm/ennV7MhIougUTTqGEMNnO8/R3m9Cv1mMbulha4v28Rquo4YCUBHI+5UDOIyNZHdtw42VS0Iw2wvxp5Xi749X51AHSd9DVtV+gfpW709ED9fLezohYHoerzWzdC0moBo/NyY8OctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537059; c=relaxed/simple;
	bh=+7vDUrAhXkZwpMtioGZjKPSdyrBSkJx5f8rdlaWzKqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmizU6fTbKTc6C12gpNqwGmGOCPQpqBdi5GZkzL9oJ/Varo2q1V93p7Khl+xbEZSE/MAKAewuFZaKB/3mxAf2I/CeyP2HaWaI7v71C1ts/cM46kpEJOINrrP0HsjPq7wT+9vT/Nt2OUUIdDap0gjSWmj97q1P0y87kTnrzynAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/fnt1gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B355C4CECE;
	Mon, 25 Nov 2024 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732537058;
	bh=+7vDUrAhXkZwpMtioGZjKPSdyrBSkJx5f8rdlaWzKqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/fnt1gzSJFvvynlbkEPVDSLjaw+oZU7IipYcAijkJHf4XfYnLxPXBQ1HDk9D1edo
	 7OKhKUB71YBuCa2eKLOzqEzorUdc3EV9pPRQ+Z0xLBiP84soL4+alum4itV/9NS8MD
	 sDfwyph0x8DH+hy0h7nPRRl7JABfkVqrT71QwIOuZe/k8cVPW1LNdlsSbCQOspl/hW
	 PnRfRbfuOFhoxTrY8geZS/H6j+5DBPr6aAzGOFZzX+gmJ2OoAhizscyLDPuQz0JXhT
	 Vf9lxx86Kpw8v8OxFB2VhNxElc7MN1C+iun2Ac2NE4D5hVEBE4WuVRH6Gotlsm+oow
	 FQYo04vX5eARg==
Date: Mon, 25 Nov 2024 13:17:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: cgzones@googlemail.com
Cc: linux-security-module@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Serge Hallyn <serge@hallyn.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	cocci@inria.fr
Subject: Re: [PATCH 09/11] fs: reorder capability check last
Message-ID: <20241125-rausch-sprossen-2570a6fe045a@brauner>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-8-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125104011.36552-8-cgoettsche@seltendoof.de>

On Mon, Nov 25, 2024 at 11:40:01AM +0100, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

