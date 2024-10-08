Return-Path: <linux-fsdevel+bounces-31339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A1C994DBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35341C24B7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF011DEFED;
	Tue,  8 Oct 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbF6rAh8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB091DE4CD
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392916; cv=none; b=Ln+7VEk8d1V1l2HwogGC1K2cFaEgRg0bRLoqf7SkFlq4CY+pngo7lY8yGZS6PPE9DauMClLGErCnozqF3l2TP6jDUrpmIOAZcccb69Ef2hDBHSMpvgV8fkO9azoquYBUS/odUR9hHNKKCX64wC8zTHuaiW5JB0VkXxX8huSWy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392916; c=relaxed/simple;
	bh=2xkP0y7JaVpNl5ajof3Zg571IFJhT6NsxqKSGZzhuyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVub8lfCHpdkcDsxKUbqirwVspI4jXc2dyUcOW/FOmTyoFS4JLVYn8i81J0jX3VjFVSJoRS7nLgq4JbmQ5ylZaVJuRDjLaB8BToJo4m8zstxszTJJFiPJLrfVCVhgtbI6Jm6ojrRJpVMuQe8k9NgjZsb8yTH1S2Ae1hWk59XmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbF6rAh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE11C4CEC7;
	Tue,  8 Oct 2024 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728392916;
	bh=2xkP0y7JaVpNl5ajof3Zg571IFJhT6NsxqKSGZzhuyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbF6rAh8w0zx+bcHuOvTFY5bCMqE4qGedE1b4kKzOI+4UXbQWaSyQsCPCSLnhM/bl
	 4rPjs2cWrMKfxYho22b5+TeKuA+I5yC/RZOqcZ9s1g4uxQ9g64L05bkytf0gcsbX/G
	 2BrP88hJQArrlWjMo3e1vBf+xjW1jjXrjGyO10kfF52RDUT886gFz1IROHYKUHw1hs
	 rDrxQb48Y9OkU9as3wsItmCVLrgXcY9oc0zW8ZIQaEsRVwurbBXiRunKnVz3ShmINK
	 I4dJh5pKJ52rZhbduqXwQG55yIqDFjmI873Qy3DnpmW44CZdKmhlNggktLrG/RoIpm
	 EZ9O/YIa3Lt2g==
Date: Tue, 8 Oct 2024 15:08:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2] hfs: convert hfs to use the new mount api
Message-ID: <20241008-fotos-darlegen-1d129828e6cb@brauner>
References: <66accd3d-b293-4aeb-abdf-483a7d17b963@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66accd3d-b293-4aeb-abdf-483a7d17b963@redhat.com>

On Tue, Oct 08, 2024 at 07:52:48AM GMT, Eric Sandeen wrote:
> Convert the hfs filesystem to use the new mount API.
> Tested by comparing random mount & remount options before and after
> the change, and trivial I/O tests.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> V2: attach sb to sbi (sbi->sb = sb) in fill_super as before
> 
> Brown paper bag time, I really only tested mount/unmount, and because

We don't do brown paper bags here. Making people fix their bugs is
the real punishment. :)

> I had forgotten to attach sb back to sbi (sbi->sb = sb) in fill_super(),

I already folded that fix into your earlier patch.

