Return-Path: <linux-fsdevel+bounces-62141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C695CB856CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20009585B04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EA8223DC0;
	Thu, 18 Sep 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JqAWS1rN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82CAD23;
	Thu, 18 Sep 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207636; cv=none; b=mMFGkjT+x5haBHg23cMeTFDnvlJwtKMywH/gBHGcY/gY9qvUe9S/KqzMZ/uRY+7EqlFGbEHcT8C/mKyQUYYud4lpeLuuSjF6eiImArNzBQQzmbGhpGFvGxdQQujQiac6++/LIkNYEFL3d7WJyj9xb/7VSG4mDDokAb9jYXwPxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207636; c=relaxed/simple;
	bh=xuOkoUNw7rn5KxPRuOp5pQL5CtBW0260AwBgcanXRXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caix/6ziTRcz2Grg8grH2S6Do6rM+nrWBYY/U1eXQxSgzdNYy0Z/5wPgW+Q8PjfLv4HaqZG3b4dFIqIHh7Cm01plixAOZP5BPuUjYbF8FjhoJCVeKXYm70Ih4uSrWMGfrlB5pu+K3ZX2VvPrXM2E3mVgqE+atL7Xe56ySkYKVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JqAWS1rN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8D4C4CEF7;
	Thu, 18 Sep 2025 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758207635;
	bh=xuOkoUNw7rn5KxPRuOp5pQL5CtBW0260AwBgcanXRXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqAWS1rNTliJuZW77rrKBWqxFqq+CDpUja0x5eSS/S5Xv5V+6XMagqVkUXpvTcunK
	 6J/PBjjXkcUciXodteyx9Cfk3RRvvhtpNYm8xG5d+NviK0n63cupwomjQaiejVQbxB
	 1c0f+0KS1oGoC1OQMzJ6pl9W02HyNJCmfoEScx4I=
Date: Thu, 18 Sep 2025 17:00:32 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: ManeraKai <manerakai@protonmail.com>
Cc: "aliceryhl@google.com" <aliceryhl@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: miscdevice: Moved `MiscDevice` to a more
 general abstraction
Message-ID: <2025091803-rephrase-deepen-52fd@gregkh>
References: <20250918144356.28585-1-manerakai@protonmail.com>
 <20250918144356.28585-2-manerakai@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918144356.28585-2-manerakai@protonmail.com>

On Thu, Sep 18, 2025 at 02:45:28PM +0000, ManeraKai wrote:
> This new general abstraction is called `FileOperations`.
> 
> `struct file_operations` is not only meant for misc. Its methods are
> accessible from any other driver type. This change, however, doesn't
> generalize the safe wrapping for all driver types, but rather just the
> method declarations. The actual safe wrappings are left for every driver
> type to implement. This may make each implementation simpler. For
> example, misc can choose not to implement the safe wrapping for `lock`,
> `sendfile`, or `sendpage`, since they have no use in misc drivers.

This has come up many times, but we really are not "ready" for a generic
file operations export.  Let's keep this just for misc for now, until we
have another use for it, as the interaction with the vfs is tricky and
subtle and full of corner cases (see the debugfs bindings for lots of
examples here.)

So for a misc device, let's just stick with what we have for now.

> Signed-off-by: ManeraKai <manerakai@protonmail.com>

Nit, we need a full name please.

thanks,

greg k-h

