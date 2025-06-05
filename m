Return-Path: <linux-fsdevel+bounces-50788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4CACF943
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 23:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7003AFBC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188327F4ED;
	Thu,  5 Jun 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wo3vaFFQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9620330
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749159857; cv=none; b=eTrM7GaB2wDfG8t0KwIrOq8S61F9vZY1F6caz8yxMgW54wUEZ6BjLMqSa8mdmZpy91kG18fU15P4McNNLszL/2KLuAkcmIVJyG5Tro1vMnjVrKIhDrZpFy+tbM6p2LsxhObEvqC/N52ZjpKFz89fLuH+daNq1Gp9GfnO5QRGBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749159857; c=relaxed/simple;
	bh=Xyy4kzai1xi0CULnkSxG2fZ+PK8LWzYKoQsW2bWLSO4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J8gCCWi12BNHhDm3PP0xm5tjHpGKaha8o1lLfWGdR0BBDUNG7+N4li68xLtizN8bYKvfgQnsFqnYlZLw52EIjWBNLh2BiR6emt2/npjLAOK9B4YY2v7bNieP5oWS6HkE3aRuD6fgqTXyM6GXUT+XBc/hXh88+xhIgESTbDcZOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wo3vaFFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D65BC4CEE7;
	Thu,  5 Jun 2025 21:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749159856;
	bh=Xyy4kzai1xi0CULnkSxG2fZ+PK8LWzYKoQsW2bWLSO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wo3vaFFQe/he1vd9C/tVMJvEq2VftK+LHKMr9dGLE5o5W2cce1l0gEIeywdYHr3WE
	 Zy69mbOYkupW04H4RQY3DqG6WWBxvNWpBiSGU/ScRaijM84t5JmeGrZIa7rot+n0GC
	 MJgzJpNbJGiUmIhGDE5mwKR9xWbKB1T7M2TOpY4Q=
Date: Thu, 5 Jun 2025 14:44:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: wangzijie <wangzijie1@honor.com>
Cc: <rick.p.edgecombe@intel.com>, <ast@kernel.org>, <adobriyan@gmail.com>,
 <kirill.shutemov@linux.intel.com>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] proc: clear FMODE_LSEEK flag correctly for permanent
 pde
Message-Id: <20250605144415.943b53ed88a4e0ba01bc5a56@linux-foundation.org>
In-Reply-To: <20250605065252.900317-1-wangzijie1@honor.com>
References: <20250605065252.900317-1-wangzijie1@honor.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 14:52:52 +0800 wangzijie <wangzijie1@honor.com> wrote:

> Clearing FMODE_LSEEK flag should not rely on whether proc_open ops exists,

Why is this?

> fix it.

What are the consequences of the fix?  Is there presently some kernel
misbehavior?


