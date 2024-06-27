Return-Path: <linux-fsdevel+bounces-22646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 905BB91AD37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F031B288AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E967419A282;
	Thu, 27 Jun 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlM70AE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B4C198A09
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507079; cv=none; b=CVZUpPlTTxzuKVC68eYBr8cJEvScha72eImFs4XltXqKM6E35n1ttalAD6bkqrawSsP+FLnOvUFfFVgf2ZCVK7hUqSdtpfdXcZnPxuFVz4ho2qmZdvPmfS/9Ticx5VurxejKhvD18CyfAWYjYdPDVVoT8T88OjeAEKl/9pHerEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507079; c=relaxed/simple;
	bh=pjPgafF7vvNINt+VWo71Ss+BNR4YFGwnv8qS+jFNpq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sband4NyH0cZ41Q7GveEcA5DZ2oteW3Nwpo/Nc3LcFNK57a6yuOTQWl6ujgDPmoUACdc4oOF/wnlfIv+8VFkeM+UUEW8BS6b62lA1+CVG7cbWowxZMRoMUdXX9KkuuEwhm4tzrDpc2GXE+Ck+vPlns5XgEB2FSOCw6t8RmMJ/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlM70AE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F433C2BBFC;
	Thu, 27 Jun 2024 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719507078;
	bh=pjPgafF7vvNINt+VWo71Ss+BNR4YFGwnv8qS+jFNpq8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hlM70AE7oXNEgi6C7rpEtUqFDlOp3GJ53RuPSg+OKo2h8aRBeVDit+TI+7ZzXQYk/
	 vqQh3Y/lp2+z7DX79z0JQ/kEfn7/SCjklrvHpr94IVcwC/ki+NQO2z7CX9YQ6Itp8U
	 8podfFnUG85xUo1r7qW3hBDnndMR6CHX3iY3R0XbaN5GJ3B/kLOykkBPWEFq1T+sBh
	 CXfMG5Om82ziS9thplkjlvM8GbP39An2drg/P4Q3Ghv+ojfvga7vEdjEy/YipJtiXM
	 C39glqB1OoAuKQC8xSSWfQCXdpBqLxmqI9mlVwMA2gnD2xsKEzxrqHa2PvUdOFw/xs
	 bWlIwzHnOHGBw==
Message-ID: <193f5a90ee2dfe9b41fc714dde8b7cea3dfe9943.camel@kernel.org>
Subject: Re: [PATCH RFC 0/4] pidfs: allow retrieval of namespace descriptors
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Seth Forshee <sforshee@kernel.org>, 
 Stephane Graber <stgraber@stgraber.org>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 27 Jun 2024 12:51:16 -0400
In-Reply-To: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
References: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-27 at 16:11 +0200, Christian Brauner wrote:
> In recent discussions it became clear that having the ability to go
> from
> pidfd to namespace file descriptor is desirable. Not just because it
> is
> already possible to use pidfds with setns() to switch namespaces
> atomically but also because it makes it possible to interact with
> namespaces without having procfs mounted solely relying on the pidfd.
>=20
> This adds support from deriving a namespace file descriptor from a
> pidfd for all namespace types.
>=20
> Thanks!
> Christian
>=20
> ---
> ---
> base-commit: 2a79498f76350570427af72da04b1c7d0e24149e
> change-id: 20240627-work-pidfs-fd415f4d3cd1
>=20

Neat. I'm not too familiar with all of the CLASS() macro stuff so it
took me a minute to unwind, but this all looks pretty straightforward.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

