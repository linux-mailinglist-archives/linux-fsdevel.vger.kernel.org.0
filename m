Return-Path: <linux-fsdevel+bounces-59069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBB8B340C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC243A43B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF772797AC;
	Mon, 25 Aug 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5bNmgo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D459279357
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128740; cv=none; b=ak9fr3Khi3BiOi382pthAQV63jUMLzX6PWm0EmcveSbV0z87Ed5a8LTmKA9vNziG197S6csyd+U0o+DkWBjuU8vDGfz/AoCvYZ7oLKAJWV5G4S5f9xkOfLXSARcaOZuXGSKGmldlcSyCjoyQoScP6YmQZ0qiWf3JH1yNUBziAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128740; c=relaxed/simple;
	bh=pAqgVnAV7c+0RuTUBPsVBglwS6Xm6n0lGrlMn7Xcadw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBk859VF+9WM+Bf6J59QJlKxXEAyuWKhf/7scSyz4Q9MWMseatfQpDmeH80IZ4h5XYZoj3nySr+T8MPshjgkAKa8apnUjT8fPSF8AjT9vCa0WQ9DG9RoTK8eFnxKiEjrI0BYP6nEJqhexUnJzSWWkZGdXJkGuwoZuij5c4RE370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5bNmgo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B64C4CEF4;
	Mon, 25 Aug 2025 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128738;
	bh=pAqgVnAV7c+0RuTUBPsVBglwS6Xm6n0lGrlMn7Xcadw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5bNmgo7i12OqkeoOAeDMQTHnRPvph8bRua4ZkGG3zDUi3mOh8R74YE9vZjtdL/40
	 3LujqFyDsjmsUrjnnoSWpNCFQ/K7sBByUrVg/g0VKV+PGWdLyo3Km+weAwUz0/K46X
	 EWm2SJYZD7TogCdgSr5o/MPLTws5lGTkA0wuIb+mR3T2UOuLrP+ZCXF1ruugf1nyuR
	 VTzLd+kIMcXEdUZaSzH8wytRmM28GFglRFphA9jFbVvEjD3so6gT92nIMjgMEqq+cY
	 jDnIH6JqQA3i+U9yjj/LHJtb1xTsCscd0NVRkzol1rnJb77FffbHnuWKIdKFeSXI9M
	 CMdrRFD60+ACw==
Date: Mon, 25 Aug 2025 15:32:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 41/52] mnt_warn_timestamp_expiry(): constify struct path
 argument
Message-ID: <20250825-bluten-parabel-7920515b4c43@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-41-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-41-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:44AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

