Return-Path: <linux-fsdevel+bounces-26062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE7E952EF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F541F2190F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9612C19DFA6;
	Thu, 15 Aug 2024 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/S6fAbY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0758149001;
	Thu, 15 Aug 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728013; cv=none; b=VxW+fVk/YVG8BaK8gnzA7w9Zxdc9THxGZOmShn6Zl1qsMBqCDW0NeP7j9sq+rvaMsccZuQp0SkFly2e/XqMS0QNIXhRE3ks7IsTxieGZFLqbZvpsIbNSTyRAi+bwwrUE5c7tcz087ENYUeJcf2HyFlctL9ZCRIeCjinV74hfWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728013; c=relaxed/simple;
	bh=QLVQ38436Y3arRkdh8x4tKJORZSuHSGBn9TeE78bsKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbHEFptfhzsWF+7gbMBAyi5iwjQmJSNZT+yAZ5oecUKlyYuPVmNKeecN4yOEPyrNtgIU2SU7GU35OmvJOJ7o83dmhWotSctr711aBpIEEwZFD6hjAkwfwPDRIl/EMlQZQT6bXse6MGiJB0cTjVrjnV37UcXInhOaWIb1hQ+dJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/S6fAbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45287C32786;
	Thu, 15 Aug 2024 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723728012;
	bh=QLVQ38436Y3arRkdh8x4tKJORZSuHSGBn9TeE78bsKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/S6fAbYxa1sg2vjzhkxbiNG3ArD1aOwPB351l3mjvWX+WWz63QJfRMB0YTYAMHh2
	 QE9Drl7l6ed2RXz3WBonmgQAtiWvR97vH7aJ80lH9SC9PRFC0HeSJcSxRSXHkmJKdG
	 SzrqqpUzdrzgr/6dTYnigVW8XetUeeYauSzQCNyviJJtI+0xsaaWLdMSLpeM1GR/2H
	 0rS5uK/k5qemhMG3Wh6zJr9737Sw6sflb8KM159s+5HA+f3svd53Yw2Rl0EteMULTZ
	 8lZ8knnO1PuAPwUwamUXe5fgH+u8u3nL5ZAfU8Cd2Td5ZdekkX9ETj0jX1VqpsDOrh
	 wVdlIU3XjHdyw==
Date: Thu, 15 Aug 2024 15:20:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] fs/fuse: allow idmapped mounts
Message-ID: <20240815-duett-verfassen-3ef04efd021f@brauner>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
 <20240814114034.113953-10-aleksandr.mikhalitsyn@canonical.com>
 <20240814-knochen-ersparen-9b3f366caac4@brauner>
 <CAEivzxeQOY6h2AB+eHpnNPAkHMjVoCdOxG99KmkPZx7MVyjhvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEivzxeQOY6h2AB+eHpnNPAkHMjVoCdOxG99KmkPZx7MVyjhvQ@mail.gmail.com>

> didn't consider setting SB_I_NOIDMAP in fill_super and unsetting it
> later on once
> we had enough information.

No worries, I probably just didn't clarify this.

