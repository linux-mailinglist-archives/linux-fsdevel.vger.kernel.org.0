Return-Path: <linux-fsdevel+bounces-31513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB7997D40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 08:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461491F25B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 06:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C0D1B141D;
	Thu, 10 Oct 2024 06:32:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cygnus.enyo.de (cygnus.enyo.de [79.140.189.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054DF18DF81;
	Thu, 10 Oct 2024 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.140.189.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728541935; cv=none; b=dvD2fByHQwqo8htTHM5eTSsoIMpywWbVbxKsXV4sm41NX+9z0+1Ezt7TEqh5Shygd+alLJkScsbmGlX7Sz9i1R5TcJQX1bc6579zYkF2EZJxvkAJzO8UADhds0sjnLypOtnB4fw8sqPOirXih+JuDZUMGv1MtaVzgx3OiBfIZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728541935; c=relaxed/simple;
	bh=V2kO13Sp536cUh/fcCKZAzX5GRu3GPW5Wblh2HA5ICE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tzuuO5VJdPxmuwg2lcq2CKhey/1RipXgloXf+ICAdi2TEIxUXQq8PguBuEp1njHUxw+K8/FIc2yO7BRP9YVT7vprLxlpj2IhqGi4KSbPKJx2zNA8CeDqEoNiEvZOyqB8BzX39hog5bfCJrW5MTNRD/5vuKxaTWzUOjuWH3DMsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de; spf=pass smtp.mailfrom=deneb.enyo.de; arc=none smtp.client-ip=79.140.189.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deneb.enyo.de
Received: from [172.17.203.2] (port=37769 helo=deneb.enyo.de)
	by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1symcq-0005LL-2t;
	Thu, 10 Oct 2024 06:26:16 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.96)
	(envelope-from <fw@deneb.enyo.de>)
	id 1symcq-00142n-11;
	Thu, 10 Oct 2024 08:26:16 +0200
From: Florian Weimer <fw@deneb.enyo.de>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Ingo Molnar <mingo@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Juri Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>,  Valentin
 Schneider <vschneid@redhat.com>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Arnd Bergmann <arnd@arndb.de>,  Shuah Khan
 <shuah@kernel.org>,  Kees Cook <kees@kernel.org>,  Florian Weimer
 <fweimer@redhat.com>,  Mark Rutland <mark.rutland@arm.com>,
  linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH RFC v3 00/10] extensible syscalls: CHECK_FIELDS to allow
 for easier feature detection
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
Date: Thu, 10 Oct 2024 08:26:16 +0200
In-Reply-To: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
	(Aleksa Sarai's message of "Thu, 10 Oct 2024 07:40:33 +1100")
Message-ID: <87jzegfp87.fsf@mid.deneb.enyo.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

* Aleksa Sarai:

> This is something that I've been thinking about for a while. We had a
> discussion at LPC 2020 about this[1] but the proposals suggested there
> never materialised.
>
> In short, it is quite difficult for userspace to detect the feature
> capability of syscalls at runtime. This is something a lot of programs
> want to do, but they are forced to create elaborate scenarios to try to
> figure out if a feature is supported without causing damage to the
> system. For the vast majority of cases, each individual feature also
> needs to be tested individually (because syscall results are
> all-or-nothing), so testing even a single syscall's feature set can
> easily inflate the startup time of programs.
>
> This patchset implements the fairly minimal design I proposed in this
> talk[2] and in some old LKML threads (though I can't find the exact
> references ATM). The general flow looks like:

By the way, I have recently tried to document things from a glibc
perspective (which is a bit broader because we also have purely
userspace types):

  [PATCH RFC] manual: Document how types change
  <https://inbox.sourceware.org/libc-alpha/8734m4n1ij.fsf@oldenburg3.str.redhat.com/>

(This patch has not yet been reviewed.)

