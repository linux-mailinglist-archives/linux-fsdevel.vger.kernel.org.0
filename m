Return-Path: <linux-fsdevel+bounces-38276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099409FEA17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 19:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01E91614C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 18:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1F198A37;
	Mon, 30 Dec 2024 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsMPfPV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC81925AB;
	Mon, 30 Dec 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735584223; cv=none; b=HuhCC6gzPUPz6JkQfN/xcw/X7MiCmpUH7tXrffvWcE0dtQnN1Srf2pzjsHkknqZtiVxIjJWQdKCKHreYQXAU6b6tcZe/UcWtSN/463ShVIJbgqy9ixHgUsX+XjVdWcQowO2l80pY8aYb70QcV0aUyJGHT9V1hIccv0y2FfE9jFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735584223; c=relaxed/simple;
	bh=xxQrfjrH6acZGQSCXU2d2R1ho7K9CFCrmMNz6CikPxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2yRSBUNaH0BiElqDeDkt90ImqR4cgIkuWkDhqr3fyP3OJTQvNkOXdKV/VUpFZlyZAffVCsOLnVfhTcj6Qf/E7/6BRaHccn8iMABUo7dAwKOuAZHrJIq57jEtn+1qNYGdKEe7vpRgPSXhxOrIKfY8fQQsBCcHBm/5H9kB6BnUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsMPfPV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4949C4CED6;
	Mon, 30 Dec 2024 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735584222;
	bh=xxQrfjrH6acZGQSCXU2d2R1ho7K9CFCrmMNz6CikPxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DsMPfPV2Uvn2eNoZACx5LjGtaoK/L+D+253zF/CdocSLaA5DpczmofISKHxwAQTzs
	 8Rlfr60BWgyrd/xJdOOLIQEgCEuCQS/aW3CMzZuYAjfAToNul0lC+cj2VcbjfObksQ
	 nM9o7mtJ5oIz8XTCtt725HuKgdz0012+/a0b4KKU/A/QWyi7uEvsvt8nDq6Je3P3v1
	 qgX+Qe8xqU8fbyRryeUVJS/PgwEVSw/TbnIn39kzhM4Lhs467wMTYE3zzaK/+Ses6H
	 OmBccMBYNq+vRID/3Gj9OBDYZlD5/TNPN3arRlMb2VYn8Imk6m4VwHjnH8NHxaut1l
	 kzuBtqCmL+8Kg==
Date: Mon, 30 Dec 2024 10:43:39 -0800
From: Kees Cook <kees@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests: coredump: Add stackdump test
Message-ID: <202412301041.E4D0C5D8C@keescook>
References: <cover.1735550994.git.namcao@linutronix.de>
 <d4b5d4c69eebd694f68ca8e7b92309d60adbe02a.1735550994.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b5d4c69eebd694f68ca8e7b92309d60adbe02a.1735550994.git.namcao@linutronix.de>

On Mon, Dec 30, 2024 at 11:17:31AM +0100, Nam Cao wrote:
> Add a test which checks that the kstkesp field in /proc/pid/stat can be
> read for all threads of a coredumping process.
> 
> For full details including the motivation for this test and how it works,
> see the README file added by this commit.

This is great! One tiny nit below...

> +#define STACKDUMP_FILE "/tmp/kselftest_stackdump"

Please move this to the local directory (and have the Makefile and/or
test itself clean it up). (Or use mkstemp()) I don't want to have "well
known" filenames appearing in /tmp for selftests.

-Kees

-- 
Kees Cook

