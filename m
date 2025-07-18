Return-Path: <linux-fsdevel+bounces-55446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D68B0A890
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B75A51F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B072E62DD;
	Fri, 18 Jul 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="CB76cakG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gOCMkUe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339AA1ACEDD
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856635; cv=none; b=pwQX0KTJMX3vGjeIrArWp/SPpaMAcXPp346ZUYZejn03YpefKzTEgBrKRti2UkSmGfDCUExxrKM89kRc6i9a3KwaGoLn/NbdgHbRyLjSAVDvavHUCcNz8JUY606MhEh4cXxKA5bWDsq6ixVKrXbmJFGlt67BNXOK3Tvy/Nmt/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856635; c=relaxed/simple;
	bh=LFjx0fcw3mY6AS8xBNl8TiO6sbOZ/vE0/fCBqAMRYvs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=SNS3/dU4zglX0J/OrffzCU7cMwxi1jwqScjOD/DyUXgqfZnRdR0ZpDKq2/T9ZmEVORwlFUbm/LTFTM/pB/BphpRh0dynvR058K6agYo83DssmlQ81tT52gv4FQq6rvhevxJp6rkKKhfuvlA7XiLEQxw9HsmLZpfowdXrlFg3vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=CB76cakG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gOCMkUe9; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 027647A0067;
	Fri, 18 Jul 2025 12:37:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 18 Jul 2025 12:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752856630; x=1752943030; bh=GbydcuDILI
	JBlMLJB7KtwQyZVMnZSaQ+cHgt7VYiJhM=; b=CB76cakG5D6yW/LID8jM/Djtxn
	LjWaG8bzR5pY+GCxsKURNNN/7V/Ps/kY9kUijWuALk+Lm4Hq1eTGWQH/60IPFU5N
	A6O9rlqemFQ4UTxAwJ9SpxAbvR5WdtAN02ubpvhzBbKIeig20CFTtu4Mry8RhoYN
	2bMBR0QfWglNJzf1lVNfV1bA1m8+P+BM1qN0EwkUr9Fq82h7OchHr9SbmJuwzY9Z
	DN28SzNDz5aEJKWZ0K2qM6AR5nSbY6VlZLB6iY9jf5FizYGeL+BtrIEx8s1AWrWw
	68QuXbjxEFFnHQ9cCxYx86IXxEFrvwVvwEGNsKE9nhqGyPpxnLZ8bpXSmqTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752856630; x=1752943030; bh=GbydcuDILIJBlMLJB7KtwQyZVMnZSaQ+cHg
	t7VYiJhM=; b=gOCMkUe9qOtWvPB9jNdjECwtkyfdUrUOQR7B6Q79osjIaeCnSd7
	0pob+QPPIwHgVsYRIo4xslCfnPOSGgrPLp3R7Qu6p41EBpjkrT0eCHfeJh7i5h9O
	GzrumKLdfkFcStebWTEyCYbP1BkC4bCu2tRMTLXogp4iO/NIegMn31EoaNVvXvk9
	IM3Z6QkMuDm1c+CP+qm1zjGh5Cu0b1E+a3u7RA+i3bEDwXAYjVPX8QAGjWfuDm9d
	QaJnggrCiPmZj4hD9x7DpoGLsEkXTdz5J7eqIycAwsiD2yL3BEXnxnV4kzU3qIRZ
	yKfwNiwoWzFEbR7uhz8xKJ51OHBr2AyJx/A==
X-ME-Sender: <xms:Nnh6aIDosad1Fs3oyRQIjQcGxFm1gSHNoaNb--344S4lB8fGiHOBPQ>
    <xme:Nnh6aC9ZZtye0Hclpgg9z_GGiHw0CLBe7MF40B24DnrmNVJsElCt-_9q-j1SxrO-Z
    PilTMgzrN2SyZqI>
X-ME-Received: <xmr:Nnh6aMCi9ahUftCuUDuLv5-snIZsn5XPr1FSt0yuOBGBUgAOng7wO8PhQk4HUlwRu6f8BsKRz-dVMGTlUUFZSknG7Do4fueXcctVmlAbIDrrFbwOtliE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtkfffgggfuffvvehfhfgjsehmtderredtvdejnecuhfhrohhmpeeuvghrnhguucfu
    tghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrghtth
    gvrhhnpedufedtgeetgefhledujedvieeikeeuieehveelfedvkeeuhfeujedtkeektdev
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvg
    hrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopehjohhhnhesghhroh
    hvvghsrdhnvghtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgt
    phhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Nnh6aPSaRJAH8lzp-2ADnPAnRnU24xSl7OGnQPe_dsBvooUyHKy8FQ>
    <xmx:Nnh6aLtQjRBYX3NQgZUSMtVJnr2v_5XyET98J-ZCNTAvXmh19pYhMg>
    <xmx:Nnh6aD3YH6cWV7qppI0bIDR7jvg40d41tE-Lzi8wZczdviiS3yShUA>
    <xmx:Nnh6aEXk3wH2oyxSIeOtLykCzBV-1nJiQc3FhXfy6LY0nlcTZz-sqQ>
    <xmx:Nnh6aJkJ0AsnPO6wAoSvXKWNkbw_qYpdiHs3igAiRtwMKs76Fw48p1rK>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 12:37:09 -0400 (EDT)
Content-Type: multipart/mixed; boundary="------------jDHEOUOWd0wLXyOyURI6aUlD"
Message-ID: <286e65f0-a54c-46f0-86b7-e997d8bbca21@bsbernd.com>
Date: Fri, 18 Jul 2025 18:37:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, joannelkoong@gmail.com
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>

This is a multi-part message in MIME format.
--------------jDHEOUOWd0wLXyOyURI6aUlD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/25 01:26, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> generic/488 fails with fuse2fs in the following fashion:
> 
> generic/488       _check_generic_filesystem: filesystem on /dev/sdf is inconsistent
> (see /var/tmp/fstests/generic/488.full for details)
> 
> This test opens a large number of files, unlinks them (which really just
> renames them to fuse hidden files), closes the program, unmounts the
> filesystem, and runs fsck to check that there aren't any inconsistencies
> in the filesystem.
> 
> Unfortunately, the 488.full file shows that there are a lot of hidden
> files left over in the filesystem, with incorrect link counts.  Tracing
> fuse_request_* shows that there are a large number of FUSE_RELEASE
> commands that are queued up on behalf of the unlinked files at the time
> that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> aborted, the fuse server would have responded to the RELEASE commands by
> removing the hidden files; instead they stick around.
> 
> Create a function to push all the background requests to the queue and
> then wait for the number of pending events to hit zero, and call this
> before fuse_abort_conn.  That way, all the pending events are processed
> by the fuse server and we don't end up with a corrupt filesystem.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    6 ++++++
>  fs/fuse/dev.c    |   38 ++++++++++++++++++++++++++++++++++++++
>  fs/fuse/inode.c  |    1 +
>  3 files changed, 45 insertions(+)
> 
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b54f4f57789f7f..78d34c8e445b32 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1256,6 +1256,12 @@ void fuse_request_end(struct fuse_req *req);
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
>  
> +/**
> + * Flush all pending requests and wait for them.  Takes an optional timeout
> + * in jiffies.
> + */
> +void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout);
> +
>  /* Check if any requests timed out */
>  void fuse_check_timeout(struct work_struct *work);
>  
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e80cd8f2c049f9..5387e4239d6aa6 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -24,6 +24,7 @@
>  #include <linux/splice.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
> +#include <linux/nmi.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include "fuse_trace.h"
> @@ -2385,6 +2386,43 @@ static void end_polls(struct fuse_conn *fc)
>  	}
>  }
>  
> +/*
> + * Flush all pending requests and wait for them.  Only call this function when
> + * it is no longer possible for other threads to add requests.
> + */
> +void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout)

I wonder if this should have "abort" in its name. Because it is not a
simple flush attempt, but also sets fc->blocked and fc->max_background.

> +{
> +	unsigned long deadline;
> +
> +	spin_lock(&fc->lock);
> +	if (!fc->connected) {
> +		spin_unlock(&fc->lock);
> +		return;
> +	}
> +
> +	/* Push all the background requests to the queue. */
> +	spin_lock(&fc->bg_lock);
> +	fc->blocked = 0;
> +	fc->max_background = UINT_MAX;
> +	flush_bg_queue(fc);
> +	spin_unlock(&fc->bg_lock);
> +	spin_unlock(&fc->lock);
> +
> +	/*
> +	 * Wait 30s for all the events to complete or abort.  Touch the
> +	 * watchdog once per second so that we don't trip the hangcheck timer
> +	 * while waiting for the fuse server.
> +	 */
> +	deadline = jiffies + timeout;
> +	smp_mb();
> +	while (fc->connected &&
> +	       (!timeout || time_before(jiffies, deadline)) &&
> +	       wait_event_timeout(fc->blocked_waitq,
> +			!fc->connected || atomic_read(&fc->num_waiting) == 0,
> +			HZ) == 0)
> +		touch_softlockup_watchdog();
> +}
> +
>  /*
>   * Abort all requests.
>   *
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 9572bdef49eecc..1734c263da3a77 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -2047,6 +2047,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>  {
>  	struct fuse_conn *fc = fm->fc;
>  
> +	fuse_flush_requests(fc, 30 * HZ);

I think fc->connected should be set to 0, to avoid that new requests can
be allocated.

>  	if (fc->destroy)
>  		fuse_send_destroy(fm);
>  
> 


Please see the two attached patches, which are needed for fuse-io-uring.
I can also send them separately, if you prefer.


Thanks,
Bernd
--------------jDHEOUOWd0wLXyOyURI6aUlD
Content-Type: text/plain; charset=UTF-8; name="01-flush-io-uring-queue"
Content-Disposition: attachment; filename="01-flush-io-uring-queue"
Content-Transfer-Encoding: base64

ZnVzZTogUmVmYWN0b3IgaW8tdXJpbmcgYmcgcXVldWUgZmx1c2ggYW5kIHF1ZXVlIGFib3J0
CgpGcm9tOiBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+CgpUaGlzIGlzIGEg
cHJlcGFyYXRpb24gdG8gYWxsb3cgZnVzZS1pby11cmluZyBiZyBxdWV1ZQpmbHVzaCBmcm9t
IGZsdXNoX2JnX3F1ZXVlKCkKClRoaXMgZG9lcyB0d28gZnVuY3Rpb24gcmVuYW1lczoKZnVz
ZV91cmluZ19mbHVzaF9iZyAtPiBmdXNlX3VyaW5nX2ZsdXNoX3F1ZXVlX2JnCmZ1c2VfdXJp
bmdfYWJvcnRfZW5kX3JlcXVlc3RzIC0+IGZ1c2VfdXJpbmdfZmx1c2hfYmcKCkFuZCBmdXNl
X3VyaW5nX2Fib3J0X2VuZF9xdWV1ZV9yZXF1ZXN0cygpIGlzIG1vdmVkIHRvCmZ1c2VfdXJp
bmdfc3RvcF9xdWV1ZXMoKS4KClNpZ25lZC1vZmYtYnk6IEJlcm5kIFNjaHViZXJ0IDxic2No
dWJlcnRAZGRuLmNvbT4KLS0tCiBmcy9mdXNlL2Rldl91cmluZy5jICAgfCAgIDE0ICsrKysr
KystLS0tLS0tCiBmcy9mdXNlL2Rldl91cmluZ19pLmggfCAgICA0ICsrLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2ZzL2Z1c2UvZGV2X3VyaW5nLmMgYi9mcy9mdXNlL2Rldl91cmluZy5jCmluZGV4IDI0OWIy
MTBiZWNiMS4uZWNhNDU3ZDEwMDVlIDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rldl91cmluZy5j
CisrKyBiL2ZzL2Z1c2UvZGV2X3VyaW5nLmMKQEAgLTQ3LDcgKzQ3LDcgQEAgc3RhdGljIHN0
cnVjdCBmdXNlX3JpbmdfZW50ICp1cmluZ19jbWRfdG9fcmluZ19lbnQoc3RydWN0IGlvX3Vy
aW5nX2NtZCAqY21kKQogCXJldHVybiBwZHUtPmVudDsKIH0KIAotc3RhdGljIHZvaWQgZnVz
ZV91cmluZ19mbHVzaF9iZyhzdHJ1Y3QgZnVzZV9yaW5nX3F1ZXVlICpxdWV1ZSkKK3N0YXRp
YyB2b2lkIGZ1c2VfdXJpbmdfZmx1c2hfcXVldWVfYmcoc3RydWN0IGZ1c2VfcmluZ19xdWV1
ZSAqcXVldWUpCiB7CiAJc3RydWN0IGZ1c2VfcmluZyAqcmluZyA9IHF1ZXVlLT5yaW5nOwog
CXN0cnVjdCBmdXNlX2Nvbm4gKmZjID0gcmluZy0+ZmM7CkBAIC04OCw3ICs4OCw3IEBAIHN0
YXRpYyB2b2lkIGZ1c2VfdXJpbmdfcmVxX2VuZChzdHJ1Y3QgZnVzZV9yaW5nX2VudCAqZW50
LCBzdHJ1Y3QgZnVzZV9yZXEgKnJlcSwKIAlpZiAodGVzdF9iaXQoRlJfQkFDS0dST1VORCwg
JnJlcS0+ZmxhZ3MpKSB7CiAJCXF1ZXVlLT5hY3RpdmVfYmFja2dyb3VuZC0tOwogCQlzcGlu
X2xvY2soJmZjLT5iZ19sb2NrKTsKLQkJZnVzZV91cmluZ19mbHVzaF9iZyhxdWV1ZSk7CisJ
CWZ1c2VfdXJpbmdfZmx1c2hfcXVldWVfYmcocXVldWUpOwogCQlzcGluX3VubG9jaygmZmMt
PmJnX2xvY2spOwogCX0KIApAQCAtMTE3LDExICsxMTcsMTEgQEAgc3RhdGljIHZvaWQgZnVz
ZV91cmluZ19hYm9ydF9lbmRfcXVldWVfcmVxdWVzdHMoc3RydWN0IGZ1c2VfcmluZ19xdWV1
ZSAqcXVldWUpCiAJZnVzZV9kZXZfZW5kX3JlcXVlc3RzKCZyZXFfbGlzdCk7CiB9CiAKLXZv
aWQgZnVzZV91cmluZ19hYm9ydF9lbmRfcmVxdWVzdHMoc3RydWN0IGZ1c2VfcmluZyAqcmlu
ZykKK3ZvaWQgZnVzZV91cmluZ19mbHVzaF9iZyhzdHJ1Y3QgZnVzZV9jb25uICpmYykKIHsK
IAlpbnQgcWlkOwogCXN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKnF1ZXVlOwotCXN0cnVjdCBm
dXNlX2Nvbm4gKmZjID0gcmluZy0+ZmM7CisJc3RydWN0IGZ1c2VfcmluZyAqcmluZyA9IGZj
LT5yaW5nOwogCiAJZm9yIChxaWQgPSAwOyBxaWQgPCByaW5nLT5ucl9xdWV1ZXM7IHFpZCsr
KSB7CiAJCXF1ZXVlID0gUkVBRF9PTkNFKHJpbmctPnF1ZXVlc1txaWRdKTsKQEAgLTEzMywx
MCArMTMzLDkgQEAgdm9pZCBmdXNlX3VyaW5nX2Fib3J0X2VuZF9yZXF1ZXN0cyhzdHJ1Y3Qg
ZnVzZV9yaW5nICpyaW5nKQogCQlXQVJOX09OX09OQ0UocmluZy0+ZmMtPm1heF9iYWNrZ3Jv
dW5kICE9IFVJTlRfTUFYKTsKIAkJc3Bpbl9sb2NrKCZxdWV1ZS0+bG9jayk7CiAJCXNwaW5f
bG9jaygmZmMtPmJnX2xvY2spOwotCQlmdXNlX3VyaW5nX2ZsdXNoX2JnKHF1ZXVlKTsKKwkJ
ZnVzZV91cmluZ19mbHVzaF9xdWV1ZV9iZyhxdWV1ZSk7CiAJCXNwaW5fdW5sb2NrKCZmYy0+
YmdfbG9jayk7CiAJCXNwaW5fdW5sb2NrKCZxdWV1ZS0+bG9jayk7Ci0JCWZ1c2VfdXJpbmdf
YWJvcnRfZW5kX3F1ZXVlX3JlcXVlc3RzKHF1ZXVlKTsKIAl9CiB9CiAKQEAgLTQ3NSw2ICs0
NzQsNyBAQCB2b2lkIGZ1c2VfdXJpbmdfc3RvcF9xdWV1ZXMoc3RydWN0IGZ1c2VfcmluZyAq
cmluZykKIAkJaWYgKCFxdWV1ZSkKIAkJCWNvbnRpbnVlOwogCisJCWZ1c2VfdXJpbmdfYWJv
cnRfZW5kX3F1ZXVlX3JlcXVlc3RzKHF1ZXVlKTsKIAkJZnVzZV91cmluZ190ZWFyZG93bl9l
bnRyaWVzKHF1ZXVlKTsKIAl9CiAKQEAgLTEzMjYsNyArMTMyNiw3IEBAIGJvb2wgZnVzZV91
cmluZ19xdWV1ZV9icV9yZXEoc3RydWN0IGZ1c2VfcmVxICpyZXEpCiAJZmMtPm51bV9iYWNr
Z3JvdW5kKys7CiAJaWYgKGZjLT5udW1fYmFja2dyb3VuZCA9PSBmYy0+bWF4X2JhY2tncm91
bmQpCiAJCWZjLT5ibG9ja2VkID0gMTsKLQlmdXNlX3VyaW5nX2ZsdXNoX2JnKHF1ZXVlKTsK
KwlmdXNlX3VyaW5nX2ZsdXNoX3F1ZXVlX2JnKHF1ZXVlKTsKIAlzcGluX3VubG9jaygmZmMt
PmJnX2xvY2spOwogCiAJLyoKZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGV2X3VyaW5nX2kuaCBi
L2ZzL2Z1c2UvZGV2X3VyaW5nX2kuaAppbmRleCA1MWE1NjM5MjJjZTEuLjU1ZjUyNTA4ZGUz
YyAxMDA2NDQKLS0tIGEvZnMvZnVzZS9kZXZfdXJpbmdfaS5oCisrKyBiL2ZzL2Z1c2UvZGV2
X3VyaW5nX2kuaApAQCAtMTM4LDcgKzEzOCw3IEBAIHN0cnVjdCBmdXNlX3JpbmcgewogYm9v
bCBmdXNlX3VyaW5nX2VuYWJsZWQodm9pZCk7CiB2b2lkIGZ1c2VfdXJpbmdfZGVzdHJ1Y3Qo
c3RydWN0IGZ1c2VfY29ubiAqZmMpOwogdm9pZCBmdXNlX3VyaW5nX3N0b3BfcXVldWVzKHN0
cnVjdCBmdXNlX3JpbmcgKnJpbmcpOwotdm9pZCBmdXNlX3VyaW5nX2Fib3J0X2VuZF9yZXF1
ZXN0cyhzdHJ1Y3QgZnVzZV9yaW5nICpyaW5nKTsKK3ZvaWQgZnVzZV91cmluZ19mbHVzaF9i
ZyhzdHJ1Y3QgZnVzZV9jb25uICpmYyk7CiBpbnQgZnVzZV91cmluZ19jbWQoc3RydWN0IGlv
X3VyaW5nX2NtZCAqY21kLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpOwogdm9pZCBmdXNl
X3VyaW5nX3F1ZXVlX2Z1c2VfcmVxKHN0cnVjdCBmdXNlX2lxdWV1ZSAqZmlxLCBzdHJ1Y3Qg
ZnVzZV9yZXEgKnJlcSk7CiBib29sIGZ1c2VfdXJpbmdfcXVldWVfYnFfcmVxKHN0cnVjdCBm
dXNlX3JlcSAqcmVxKTsKQEAgLTE1Myw3ICsxNTMsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
ZnVzZV91cmluZ19hYm9ydChzdHJ1Y3QgZnVzZV9jb25uICpmYykKIAkJcmV0dXJuOwogCiAJ
aWYgKGF0b21pY19yZWFkKCZyaW5nLT5xdWV1ZV9yZWZzKSA+IDApIHsKLQkJZnVzZV91cmlu
Z19hYm9ydF9lbmRfcmVxdWVzdHMocmluZyk7CisJCWZ1c2VfdXJpbmdfZmx1c2hfYmcoZmMp
OwogCQlmdXNlX3VyaW5nX3N0b3BfcXVldWVzKHJpbmcpOwogCX0KIH0K
--------------jDHEOUOWd0wLXyOyURI6aUlD
Content-Type: text/plain; charset=UTF-8; name="02-flush-uring-bg"
Content-Disposition: attachment; filename="02-flush-uring-bg"
Content-Transfer-Encoding: base64

ZnVzZTogRmx1c2ggdGhlIGlvLXVyaW5nIGJnIHF1ZXVlIGZyb20gZnVzZV91cmluZ19mbHVz
aF9iZwoKRnJvbTogQmVybmQgU2NodWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPgoKVGhpcyBp
cyB1c2VmdWwgdG8gaGF2ZSBhIHVuaXF1ZSBBUEkgdG8gZmx1c2ggYmFja2dyb3VuZCByZXF1
ZXN0cy4KRm9yIGV4YW1wbGUgd2hlbiB0aGUgYmcgcXVldWUgZ2V0cyBmbHVzaGVkIGJlZm9y
ZQp0aGUgcmVtYWluaW5nIG9mIGZ1c2VfY29ubl9kZXN0cm95KCkuCgpTaWduZWQtb2ZmLWJ5
OiBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+Ci0tLQogZnMvZnVzZS9kZXYu
YyAgICAgICAgIHwgICAgMiArKwogZnMvZnVzZS9kZXZfdXJpbmdfaS5oIHwgICAxMCArKysr
KysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9mcy9mdXNlL2Rldi5jIGIvZnMvZnVzZS9kZXYuYwppbmRleCA1
Mzg3ZTQyMzlkNmEuLjNmNWYxNjhjYzI4YSAxMDA2NDQKLS0tIGEvZnMvZnVzZS9kZXYuYwor
KysgYi9mcy9mdXNlL2Rldi5jCkBAIC00MjYsNiArNDI2LDggQEAgc3RhdGljIHZvaWQgZmx1
c2hfYmdfcXVldWUoc3RydWN0IGZ1c2VfY29ubiAqZmMpCiAJCWZjLT5hY3RpdmVfYmFja2dy
b3VuZCsrOwogCQlmdXNlX3NlbmRfb25lKGZpcSwgcmVxKTsKIAl9CisKKwlmdXNlX3VyaW5n
X2ZsdXNoX2JnKGZjKTsKIH0KIAogLyoKZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGV2X3VyaW5n
X2kuaCBiL2ZzL2Z1c2UvZGV2X3VyaW5nX2kuaAppbmRleCA1NWY1MjUwOGRlM2MuLmZjYTIx
ODRlOGQ5NCAxMDA2NDQKLS0tIGEvZnMvZnVzZS9kZXZfdXJpbmdfaS5oCisrKyBiL2ZzL2Z1
c2UvZGV2X3VyaW5nX2kuaApAQCAtMTUyLDEwICsxNTIsMTAgQEAgc3RhdGljIGlubGluZSB2
b2lkIGZ1c2VfdXJpbmdfYWJvcnQoc3RydWN0IGZ1c2VfY29ubiAqZmMpCiAJaWYgKHJpbmcg
PT0gTlVMTCkKIAkJcmV0dXJuOwogCi0JaWYgKGF0b21pY19yZWFkKCZyaW5nLT5xdWV1ZV9y
ZWZzKSA+IDApIHsKLQkJZnVzZV91cmluZ19mbHVzaF9iZyhmYyk7CisJLyogQXNzdW1lcyBi
ZyBxdWV1ZXMgd2VyZSBhbHJlYWR5IGZsdXNoZWQgYmVmb3JlICovCisKKwlpZiAoYXRvbWlj
X3JlYWQoJnJpbmctPnF1ZXVlX3JlZnMpID4gMCkKIAkJZnVzZV91cmluZ19zdG9wX3F1ZXVl
cyhyaW5nKTsKLQl9CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBmdXNlX3VyaW5nX3dhaXRf
c3RvcHBlZF9xdWV1ZXMoc3RydWN0IGZ1c2VfY29ubiAqZmMpCkBAIC0yMDYsNiArMjA2LDEw
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBmdXNlX3VyaW5nX3JlcXVlc3RfZXhwaXJlZChzdHJ1
Y3QgZnVzZV9jb25uICpmYykKIAlyZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyBpbmxpbmUg
dm9pZCBmdXNlX3VyaW5nX2ZsdXNoX2JnKHN0cnVjdCBmdXNlX2Nvbm4gKmZjKQoreworfQor
CiAjZW5kaWYgLyogQ09ORklHX0ZVU0VfSU9fVVJJTkcgKi8KIAogI2VuZGlmIC8qIF9GU19G
VVNFX0RFVl9VUklOR19JX0ggKi8K

--------------jDHEOUOWd0wLXyOyURI6aUlD--

