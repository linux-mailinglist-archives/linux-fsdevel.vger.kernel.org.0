Return-Path: <linux-fsdevel+bounces-53225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5ACAEC9C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E5C6E05E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 18:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902BA21ADA7;
	Sat, 28 Jun 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq5Evuo1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A441DE88C
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751136319; cv=none; b=NjElKR//8V9OJH1Xl7eMNYxzW7f7wJ5iIbivhQri44F+i98C44SB1sXsfnmN8riBXee9qEi3jf+6f/cO9LnG/l8Ra6EkWpUzYswPvy397ePKfqFEJtAmO5GvYMLHoGl3okmhkHhaarFZMSvbAZ3VNsc/F7DotkPxDXPKCWRhGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751136319; c=relaxed/simple;
	bh=19iKrBtuXFFKcH2OGfNTRlOF8fhSC2Ym/FixLbPm6Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPdCbs6yxgdUgrTRcHLYHcZdrUx4HFf1CnqkjMsbfg6Q/6ho7uv6vfk3a2gPpLH5eVCOpHmr5uMmA17wM/a7ubqRTTCSMPdJpwGskhFeYvRvquKdicKftc2RivRPnTMoBtV8lOEzWx67+Ons2CalqloFu2pbzPceESsTTldUE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq5Evuo1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so1818113a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751136314; x=1751741114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19iKrBtuXFFKcH2OGfNTRlOF8fhSC2Ym/FixLbPm6Lo=;
        b=hq5Evuo1rOmFVvBwl67J2LzwArqwj4UPn87I7NZXR2gMywCebUIPqubCf41recirgS
         aZ74OJGdtCT7+vJsmr0l7DW/j/VPNEi3TKE2t1V+8UTfGc4J8itfEryIOixtfa1DcWDL
         /Qv+H6+kWFQLUhUUH8Cl/JXZa7coG6ooeLwChFcd4LZxx3aG8FkC1GlSB9OXB+ukFnXZ
         +Pbt6xsAgEr2CF5jipzOLQe4RqMUA+SZAGMMZmUU3NSABnbOu/4IAKinttMnGRTQhQob
         JwvbZye2s+ktmVS7IoWiHCmP0opMaP2XI06vcdnx93KOJCYtydTaXaBiAG2QXJy0J/qJ
         kGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751136314; x=1751741114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19iKrBtuXFFKcH2OGfNTRlOF8fhSC2Ym/FixLbPm6Lo=;
        b=aupNip9mSLf6cRcCO3zbny74O4EhlaV8YXVdd7lIKxCTp3NyZhNcB1EXvf/ljyhB/R
         k0ra4FWpLmv8FHfzgz2i8i/wYIYLUtvh5ZKLsWJKgIUq8tW1UFREBBsGTQnDEhk3QurT
         R25G9JpN5yWz9nD6z+O9fuiywMSnoTA5l4IFtLVhoIFQSYtrnBJhbguw+P+RN0yjZ3Vq
         INciCnECOZF6e8frmL7bchIo27YN8juY8ojEzVlF5cg3Gk/zqJJ9NM522v2xaxwNyoyb
         7I09FrkxKvH/J4TXM2Rcdg5DMYtmqm6jLOYJUg6xwnMuIwYAiO09jl3yFCD6AHxrp5vy
         c72g==
X-Forwarded-Encrypted: i=1; AJvYcCWLi5iFfcrzQ0/aI4UgX9aUxKPUTVsNpi0/npFG+g8JptEF5+D00N86iWEyJG/hJ0RnRzVEy5ZUyP7giDyd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5n5m+bL+3p773FcG4gOm6RprXIRpQuJBziQk18ttV31vLEFV9
	IkOeZNsL5OsYWD6D/GgkN9VCMaUSEVIjn4pf4Xpnhh8gKO/Nt/zPQshTXyUfd0OLPv/M2BjFmBG
	4kruKgv2rq25JU9HK/gfGYsZ4alLUK2d2/hVwIFg=
X-Gm-Gg: ASbGncu5yGaPP/c+sPq4GxLTDIVTAzHcevVFEP9i9tkyHpssR0SSvFXJC4mcJKLRMOH
	GYbQHnVkJkYMBEyrUdlV/qC/3VDVNwHd541uiujnX5Y/nkszZkyL20CF4EY/f7lMmk03bbSD9Xs
	l20rNuecUDb9DOyZeBO/9FbPu7uIDyaYJYlX7g8lKMCR0=
X-Google-Smtp-Source: AGHT+IG85FwOf+PbRoMfV81Z7T0UcQX8NtlMfWtLhuDKUVXgIl0IjR1KBBimtGTy1rGXVBXuvNmtEF4UDOue0bujvMU=
X-Received: by 2002:a17:907:7288:b0:ae0:3f20:68f8 with SMTP id
 a640c23a62f3a-ae3500cbf41mr707145866b.39.1751136314199; Sat, 28 Jun 2025
 11:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bc4dvylqapkxdqme65cudioajevdcjvwesmgh5v6jmghosyoux@sazv6a4q3hml> <20250626185235.1229065-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250626185235.1229065-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 28 Jun 2025 20:45:02 +0200
X-Gm-Features: Ac12FXyCGR8IHzMQ4Q9PypafdGWQhgj4cglSnvm5Jc7cElKY9ptPwjx5OHJd6lM
Message-ID: <CAOQ4uxgVMpcu2HvvO6Fn0Tx+nxo0pJzrkzzP4nJiSur2k3azoQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: selftests for fanotify permission events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:53=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> > On 6/26/25, 3:49 AM, "Jan Kara" <jack@suse.cz <mailto:jack@suse.cz>> wr=
ote:
> > On Tue 24-06-25 07:58:59, Amir Goldstein wrote:
> > > On Mon, Jun 23, 2025 at 9:45 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.co=
m <mailto:ibrahimjirdeh@meta.com>> wrote:
> > > >
> > > > This adds selftests which exercise generating / responding to
> > > > permission events. They requre root privileges since
> > > > ^^^^ require
> > > > FAN_CLASS_PRE_CONTENT requires it.
> > > >
> > > > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com <mailto:ibrah=
imjirdeh@meta.com>>
> > > > ---
> > > > tools/testing/selftests/Makefile | 1 +
> > > > .../selftests/filesystems/fanotify/.gitignore | 2 +
> > > > .../selftests/filesystems/fanotify/Makefile | 8 +
> > > > .../filesystems/fanotify/fanotify_perm_test.c | 386 +++++++++++++++=
+++
> > > > 4 files changed, 397 insertions(+)
> > > > create mode 100644 tools/testing/selftests/filesystems/fanotify/.gi=
tignore
> > > > create mode 100644 tools/testing/selftests/filesystems/fanotify/Mak=
efile
> > > > create mode 100644 tools/testing/selftests/filesystems/fanotify/fan=
otify_perm_test.c
> > > >
> > > >
> > > > Hi Ibrahim,
> > > >
> > > As a general comment, I do not mind having diverse testing
> > > methods, but just wanted to make sure that you know that we
> > > usually write fanotify tests to new features in LTP.
> > >
> > > LTP vs. selftests have their pros and cons, but both bring value
> > > and add test coverage.
> > > selftests would not have been my first choice for this particular tes=
t,
> > > because it is so similar to tests already existing in LTP, e.g.:
> > > https://github.com/linux-test-project/ltp/blob/master/testcases/kerne=
l/syscalls/fanotify/fanotify24.c <https://github.com/linux-test-project/ltp=
/blob/master/testcases/kernel/syscalls/fanotify/fanotify24.c>
> >
> >
> > Yeah, frankly I'd prefer to keep tests in one place unless there's a go=
od
> > reason not to. As you write in this case we already have very similar t=
ests
> > in LTP so adding a coverage for the new functionality there seems like =
a
> > no-brainer...
> >
> >
> > > but I suppose that testing the full functionality of event listener f=
d handover
> > > might be easier to implement with the selftest infrastructure.
> > > Anyway, I will not require you to use one test suite or the other if =
you have
> > > a preference.
> >
> >
> > If there's some functionality that's hard to test from LTP, we can cons=
ider
> > implementing that in kselftests but I'd like to hear those reasons firs=
t...
>
> I missed the existing tests present in LTP repo. Will resubmit the test c=
ases
> for new functionality to that repo rather than adding them as selftests.

As I wrote in another reply, please see test fanotify25 that I forked
from fanotify24
for testing new pre-content events API:
https://github.com/amir73il/ltp/commits/fan_pre_content_fid/

I do not wish to fork a test for every new feature and config variant.
I'd rather test all new features in a given release in the same test if
they are related.

Feel free to add FAN_REPORT_EVENT_ID testing to fanotify25
because I do not plan to leave the event->fd when reporting fid info
unless I have to, and even if we do leave event->fd, you can use the
test_variants iterator to run all test cases with and without
FAN_REPORT_EVENT_ID instead of duplicating the test code.

See this test variant expansion for example:
a4377184c ("fanotify21: Test reporting fd open errors with FAN_REPORT_FD_ER=
ROR")

Thanks,
Amir.

