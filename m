Return-Path: <linux-fsdevel+bounces-51279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9108AD51D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0341317B495
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169B1265281;
	Wed, 11 Jun 2025 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnP/fPW7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A5D262808
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637780; cv=none; b=fVQ+BzQD4paEqHdgiKyA1ALL5b1vjb6IWgx8C5DmugkuJPSZXdIfZCjgowDopeFcbhqpALC1K79UWFEIDkGIGegiuZ5Gw406zMYRJ0mi6zvWYYTph+aHoW698pFsN574eZr3nvlZTjvAxkAxbMPPsLhxBogHgTp9rF5fPfCp8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637780; c=relaxed/simple;
	bh=Uzczz80MOYf6cJeOdwDRKESjyXmccV8gtJvTuB55F3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzDpPYD5AuDkAEZvg+k2PC5534SFshkTkVppGlF9IjgTQ6mrF2SYMh3EUJidfXpq/K9DRYyHp4WkFAJZVrIf+1USIFneqJcuPa3TEUk8qQB09amCVrw4BkJqlBKXgXsrdJNyvz9+QI/D+SbchNNClqB3l4XxSbpwvdEMTMpH0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnP/fPW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512C2C4CEEE;
	Wed, 11 Jun 2025 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749637779;
	bh=Uzczz80MOYf6cJeOdwDRKESjyXmccV8gtJvTuB55F3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnP/fPW7N8CxoI2ntRyHCSzmXA3yTtawGk4OAIamVK4pIPJDXtFZxxUK8vKe9EcY3
	 MfvV0u9AOxbjsA2iFYkAol+0zYaS+u9GZDrlmGjJeiBRrpDd74jy9fgwoWrTg1plle
	 rwsttw8Q+aYPalRPjNwzlWYSoQT8JKk9zaL8KfX0TcrGBXFvRIVRp0HlaLL01QTejU
	 5g3NPASrmtkMg3Fx5ctaV7UYe3I4eDccsn+72Cbz/IKAXATg3epkVbxiMQOVTLZEe/
	 qnU5A2oFAnVcHII94e6dsX8Zr6USC2QIPxHfMgvj6Ru9HcHWq08DIrzhZMUvlrqLTN
	 sa8aXDRofT9eQ==
Date: Wed, 11 Jun 2025 12:29:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 03/26] pnode: lift peers() into pnode.h
Message-ID: <20250611-zecken-punkrock-432615fc4f11@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-3-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:25AM +0100, Al Viro wrote:
> it's going to be useful both in pnode.c and namespace.c
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

