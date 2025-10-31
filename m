Return-Path: <linux-fsdevel+bounces-66641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102EC27285
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A88A04E579B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE37313E13;
	Fri, 31 Oct 2025 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b="CGdJbVRK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C934D3A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951739; cv=none; b=dCiPUfIf0u9IfYegW00VSNmKbRhn6Lzm7C0aZtUW8T4ckygioEKce7X3oImT44CPwjRl6MWXKKCsO3xWwoHzIBdMSQdBJZHUzw6MsZTpwAP9je30lFlKP591X1cg5ysURLPeshHGgCfPJ+F77nKifjdnif4nGfsvFzhA5XFdj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951739; c=relaxed/simple;
	bh=dkkiiNKD2C5NZlYDwgeiyXOzcpGbpU9vNmHlzaasORA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=B2AYUUUHc0KkjkH1ckYUNAg8OTrkiLlbL7Cm0XUN7TGjU8PHvmR6b6tYcCIUC1Zdn0RGyQoCv4d6yr58Ex6k7SrOCgwX6npLGzF17ME+0XY/lFnXaZ5BTQxt2so+Fhdjl3izXjaAECTIc1Eg0c69cudp2B4XO2IruNikdU/90Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe; spf=pass smtp.mailfrom=snai.pe; dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b=CGdJbVRK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snai.pe
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so4254742a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snai.pe; s=snai.pe; t=1761951735; x=1762556535; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2mGTrfvZdeqbKsLj35FjKAV1ImJtJWaiyZ7KAcV1494=;
        b=CGdJbVRK1APIhvpuVEd3hjS0aJMVrpfwjbCxxWoQUXMX1IcIB74Tj/ZMZldIshO+O6
         7NXjEjB6lPgFj6N7BwOX+2eh22SmRVaXdL2fPC14XDVAbEb47i0uPPhhOmexMkQ/vpTV
         j4J5Ng8nDgOt4yXEbYfWee02xYAQe1Y3XcJkuHf7f/m87VDTFQq/UR5Y9W/QQdVYsZh4
         oVghSCpCIc/udVyqk6LnEwx8Bd55BKhCcf+/aEzA8eUWrYpswuvPswollKoZ1H1G0Lgd
         LoIhMhkVYn6zu1CLmUk0hjvGKIak62VUxwmTJyuPP8sL0a1mT+PczV118aZ+3dMMomBH
         aZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761951735; x=1762556535;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mGTrfvZdeqbKsLj35FjKAV1ImJtJWaiyZ7KAcV1494=;
        b=h1k0nvq/BGKVlWtQ7dqS64UEsUkCAckFDLzYWHl36rB0tDLpBh6mQWkSCL5hgTWb1W
         OgABPbv8CFOgSifIU/pvpGCMGAEhLWlrsqh80VELN1oQZSCYcYj1/FMFNG7O5+9piBxa
         zQoyg8EH2lcovDr3IxRDTPL9LMxH13zR2J5Ck955U+ukXD6eAO66KE5EUzcWmowtr/eF
         JJ1D63l7trJRqhIegmesKDI2/8Fbu+W8wyaIGfqhcSSZ+ILgyaSHODhPPsOSKp4yJzV0
         ItN3T46DuZj3uNSYIOKDb12lgWYeHCaqPpRZZfrIM8/EMa39c1BYRFbVbiaQ++1bsaAg
         euwA==
X-Gm-Message-State: AOJu0YyVafNpC4kjhuYdkoGW9rv972AFM6vrSeSwOgyBs8BZiEMDKWZ0
	7Js5ODlhy47LTvolJOxCrRbHEaqj1ZJHrLzVDbfbQPt1tey3TfB5lmdm3mcRs65mld7yPSYs/sG
	dhSLgvkg3eWAa2aAZAQwiASMvY8QKYKbZW2+kGs03MAy2y7v/sQ0o
X-Gm-Gg: ASbGncteLI7AQoO+NrlkPkS3gq0fuKvnirCi9ZcgSxVTBKoCNdrbtQvrW+2V2IzW93L
	nkky9iJaMIg5+r4ifFN99I90tEIXjOiXrT7O36j+pt3UidTHsCSMndkHLA/VuTN7MtILaIP9PEd
	aLc2GzEMC1Q29Ai0Z7edqsiZfJpu392roYuo0j1jnmGj8TA7rB9wa3Jaid56AxMNkyCHM297z8T
	2L33SAPhvhClZ3V7vdG5BBBEDz2h0NL2bk46by1EVR8FKIwzUpCaQDj6r22ZNz3WTTnzm0=
X-Google-Smtp-Source: AGHT+IHDjWyrAfJk1JnQH5wyzNehmPH2se9qv7SYkzdv7qGyQLGaiuM4wdBRmDwZK3IUAnVV/MHEB7Il7xPmpGo4co8=
X-Received: by 2002:a05:6402:90c:b0:640:80f4:3914 with SMTP id
 4fb4d7f45d1cf-64080f43d61mr2600150a12.19.1761951734759; Fri, 31 Oct 2025
 16:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Snaipe <me@snai.pe>
Date: Sat, 1 Nov 2025 00:01:38 +0100
X-Gm-Features: AWmQ_bkSL9gShHG0uWiB4CYGWKRnDw_r3ro-ZF6TTXpkYRZCjMayS2BPLkGoAHU
Message-ID: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
Subject: open_tree, and bind-mounting directories across mount namespaces
To: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

(Disclaimer: I'm not a kernel developer)

I'm currently playing around with the new mount API, on Linux 6.17.6.
One of the things I'm trying to do is to write a program that unshares
its mount namespace and receives a directory file descriptor via an
unix socket from another program that exists in a different mount
namespace. The intent is to have a program that has access to data on
a filesystem that is not normally accessible to other unprivileged
programs, and have that program give access to select directories by
opening them with O_PATH and sending the fds over a unix socket.

One snag I'm currently hitting is that once I call open_tree(fd, "",
OPEN_TREE_CLONE|AT_EMPTY_PATH|AT_RECURSIVE), the syscall returns
EINVAL; I've bpftraced it back to __do_loopback's may_copy_tree check
and it looks like it's impossible to do on dentries whose mount
namespace is different that the current task's mount namespace.

I'm trying to understand the reasons this was put in place, and what
it would take to enable the kind of use-case that I have. Would there
be a security risk to relax this condition with some kind of open_tree
flag?

Thanks,

-- 
Franklin "Snaipe" Mathieu

