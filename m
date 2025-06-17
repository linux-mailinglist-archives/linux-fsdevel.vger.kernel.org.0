Return-Path: <linux-fsdevel+bounces-51892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 935D5ADC8F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 12:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6D07AA964
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E0293B72;
	Tue, 17 Jun 2025 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsbKzOzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D21DE2CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157803; cv=none; b=WHrCyHP5Ee6UX6fg1fUUvckFJGr4VeLrOTgzahlsr47vKMX9maHTnLib2GYUrPUF0UPM3cUIIEVleFCUO4Z/sfbUSJwOM1EQtKcm8fIjveXjiZXQiUnpxFDGo3taFENi1cUyfayMeQOiiSC2LsVlouNbHIyJwI+8bHMOazvQxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157803; c=relaxed/simple;
	bh=+xllzCLpWk6OBTxQ40D4gGfQeaOrP6eCFHfDmblcFwk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6PbehcZEo/OaCHGCNtwNtbDLeOAG82f/k9+jKdArPq0je0dJxGkZaZl2AvlyzsyCRTZ/+nmHx9m9NkesLLEyI8cfV+9xYlFY5CvzuTZdFEJ8xAMQK4D5udQMOAwgmppX+VScCGmSgfCLQskWiWucfbIQ8epF/In7fRljq79jyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsbKzOzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D559C4CEE3;
	Tue, 17 Jun 2025 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750157803;
	bh=+xllzCLpWk6OBTxQ40D4gGfQeaOrP6eCFHfDmblcFwk=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=ZsbKzOzbRJblp71I9taDhEH5um2cO4YL3wx6yPvTWGO7gAtbcEn4/JZf/SRDX+Ee+
	 Xi/f3UnxE0mPcQRmrDePsT+mBKvZaNt8t021iC146fzFJ1ixW/6I0vN2R3VosgY+rM
	 6n5U16Wx12GlgLu3bopGpaqoHpuRjDOKEDTOZIdVLAn8LIVAy2cDV7nzGLXfT4lk6n
	 h4pha0WhhJkko+RcJDv9q4/zHwDlRLeSY/9+31U3NzoKoF5hjKq52ZU7ug9ut9vkew
	 6P2FRJP6wX7A3nt4BthhsbEn+wqtPRNsW7Net59o7i53CWzcsxH/8h5HCNjo9dej7u
	 uCXQCAbEf8R4A==
Date: Tue, 17 Jun 2025 12:56:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] pidfs: keep pidfs dentry stashed once created
Message-ID: <20250617-krampf-befestigen-87a3f775dd47@brauner>
References: <20250616-work-pidfs-v1-0-a3babc8aa62b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616-work-pidfs-v1-0-a3babc8aa62b@kernel.org>

Yesterday night I realized this suffers from a lock inversion bug
between pid->wait_pidfd.lock and dentry->d_lock. I've fixed this in the
new version I'm about to send out.

