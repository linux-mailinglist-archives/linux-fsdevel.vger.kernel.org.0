Return-Path: <linux-fsdevel+bounces-17459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB6C8ADCE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29308282DDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 04:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053EC1CD39;
	Tue, 23 Apr 2024 04:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vhsmVanj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF754C8F
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713847126; cv=none; b=Erjbqg/KWdl52645mAEIHrUD6y/FuJrbTYaARrnximWP8wtsasY1ERXNBeIbU1zYB5gZ9Vamreali1HZKU4BusousNVP26H9fnp8sOmQsfWEcxw8G+hl6N/B3HwsS25jgKNRJwkfD6eM6dgU+ZdItmrqR6jwiSmycQN7JtkJU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713847126; c=relaxed/simple;
	bh=8zLpp9mVot11CPZDewWAIuzNDzwoKcqyLjXqQ5AvPhA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JLfjFsfakyl74sgV9QfVEjTCZuaeHNb6gWM/Emly7LbHiuoeiSDYJaQW5ccGatkm8lI1j7xFRkMukx8qa/7nn16LOhPiLCKDoycMkdYMGVHBRl7YisY65s4dEGKI6yMtm4hWQGFtnYsI3tfPUfPiAXZ0g6iJT/ubTsRLjtPgQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vhsmVanj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0ZjMRl62Yov2vellt8SscE+RG0orHbP8Q+tweEmdSfE=; b=vhsmVanjOjkjlpQ7lK90Odd9AE
	z3zWczW9pxfZ5xmav5yvIwJHZTeHz+LtvfjxVzrJuCFGhj1k7E2NdDygg9fbZQc9m5I6qfwoZz0Ik
	pVLteFIp/sGjyaoMApG8XWHg1N4FV6vJPJMVL1LOac/iG4m2UTVJ5YZUp4fsxytYdSOsTrFiYTlKQ
	VrDxolCQggT3T8WhiANfPNJWzcB0gD0sKV4OAHSHTynarPIdBUVfOg+2XSnkVmg9G2FGC2154Vwa4
	+QTIvfFXWsMSSly//Ssu5Xm1ar3aXLgqzsN9yjbFn3+Pzltz5Fni9pMxpsX6Zd5xeKd6X7szBVZu8
	Va+l+VFw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rz7vV-0000000Fbyn-43eu;
	Tue, 23 Apr 2024 04:38:42 +0000
Date: Tue, 23 Apr 2024 05:38:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [RFC] Saner typechecking for closures
Message-ID: <Zic7USbiliQtnKZr@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

What would you think to this?

+++ b/include/linux/delayed_call.h
@@ -14,13 +14,12 @@ struct delayed_call {

 #define DEFINE_DELAYED_CALL(name) struct delayed_call name = {NULL, NULL}

-/* I really wish we had closures with sane typechecking... */
-static inline void set_delayed_call(struct delayed_call *call,
-               void (*fn)(void *), void *arg)
-{
-       call->fn = fn;
-       call->arg = arg;
-}
+/* Typecheck the arg is appropriate for the function */
+#define set_delayed_call(call, _fn, _arg) do {                         \
+       (void)sizeof(_fn(_arg));                                        \
+       (call)->fn = (void (*)(void *))(_fn);                           \
+       (call)->arg = (_arg);                                           \
+} while (0)

 static inline void do_delayed_call(struct delayed_call *call)
 {


That should give us the possibility of passing any pointer
to the function, but gets us away from void pointers.  I did this as a
followup:

-extern void page_put_link(void *);
+extern void page_put_link(struct folio *);

...

-void page_put_link(void *arg)
+void page_put_link(struct folio *folio)
 {
-       put_page(arg);
+       folio_put(folio);
 }
 EXPORT_SYMBOL(page_put_link);

and similar changes to the three callers.

Or is there something newer and shinier we should be using instead of
delayed_call?

