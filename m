Return-Path: <linux-fsdevel+bounces-12515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA5860270
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 20:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B999282E7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24FD1EA95;
	Thu, 22 Feb 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yU/YvvKW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55614B83E
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629366; cv=none; b=ZYQs3HDRVwzVRcuKscVHEHP256TCEdZF6mtkh8N2KlCG8Y4kcFM/bpwJAzGr/6lGB52VFlrwPHsUQvV0BgC9ksrpakUSiUw4LhaUu25EAGt8SIB0bVjU0gIZLZSGayjCrmT4NV1aweag0yMs/OSNmO2+3XWVloBo2H1nvMuUelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629366; c=relaxed/simple;
	bh=5Brm7cYLz1WncvBj6DTMuWNmXDrJrz/GLli2N2sCO2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fI2577eeZ/v8R+gtZulR8iSHQRjVIOSJsBScsLP+AsVh1yMZuFvJIjW/ZuIl+5Q5LGDtz/NafGSvlsug9rHIqrLrrM+Obc8ZUmbq46r/8A/XLr5NUXu/WEOCa2WU1T/QQls0P/Dum1cDnOHaCtRs9oC6+asVBIYp+X8pHV4h9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yU/YvvKW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so27323276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 11:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708629363; x=1709234163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMUm3t0lorhkF3irlFp+ZHb+WnWzsj32jWcajitTJIk=;
        b=yU/YvvKWcPq/8ls1t9XJtLKh1ZoFIaJJEp8nS6IdfY5E5K504L1xynHPW7KIpNIQTU
         wWDMxgOfInxZ9OjC1SALfsS4UkSx4N9gcs7PdPZ1d20wDNLTgog1EoNG1xVyZlU6RT7e
         ZXK+x0Pgp8zJn4iXqOUIAPHJ7zkyUvVa96wuLCYUGjMuRHIlqNrDZ2piU9UfTC3yGcPB
         3m/dBZAAUSmTj4oxFjVGBmW3pxtKTFunSrwpzVBz0BzZSy4nIuUKvln38KL5pEcFbfGc
         gtyn8O+rwZeQxISjaSgZpnTr/8vy+kDn+qmbzt1ec84tdZPDqoIyRsxsSDsfGsBXzbNr
         83tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629363; x=1709234163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMUm3t0lorhkF3irlFp+ZHb+WnWzsj32jWcajitTJIk=;
        b=FZ0L2RdeAwlayyFw39huJefUjs8DD0cDt+LUUljwdAGvxOhMpym+gnHZWRzvDM61wE
         AAxPkMnP6dZadjD9SIg8Q0C15IUYBTJSxqYR/AIaZQ70+0DsXTjc5s8yHxB62OBOe1nn
         6FbAX8Mt/zWsPBpvPc8KDYrBDlJ4nE6xYmvkgBZTlrwxzMNe5Vm/cjN+hobV8rsom+ZP
         2I+FMdiGB4nYOpaK0eRTTFjpthParobgmOqi7QRR7EWCX3i6Wqpd1nSXsQkAXeTXt4Ro
         G4BgxfoEh4T4MRfrS0UKdNSe+Gdv5TjO7x8G8ZGVk28RE2JgWIBFYBFUsUgzeEA1a69Y
         2ZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNfcA8WNIfDsM4ojWKGZbDSh4toulNd/m60xFmdnILTsqqXhNznPUt1WBuISOqKVjuZi7jf8qmW0Sn4ySj7UoxCVhyWpiqdhz258iQ2Q==
X-Gm-Message-State: AOJu0YyMeGuSLyW8RR/6SspeXKGnAs9WJ/WIqym0SNJOuYY7VsugQmKI
	Q3SOOmzczDQR238XL8Up2I1W9vcVJWi+tvAYx33KbHF3ngsdLGyguJUibT3PV6OdTUf1PFqUMTk
	nxk3Cny6xqN77tVIJWw==
X-Google-Smtp-Source: AGHT+IErsJKDN7B0tFhqzkw22OBlmNI2VCFCW5jr+ldBfGgfOTaIcEOTFZlyakeEI7zsf/NVho1iuq1vdkwNZv3S
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:10c3:b0:dcc:8927:7496 with
 SMTP id w3-20020a05690210c300b00dcc89277496mr795ybu.5.1708629363699; Thu, 22
 Feb 2024 11:16:03 -0800 (PST)
Date: Thu, 22 Feb 2024 19:16:01 +0000
In-Reply-To: <ZdeaQMDjsSmIRXHB@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2701740.1706864989@warthog.procyon.org.uk> <Zbz8VAKcO56rBh6b@casper.infradead.org>
 <ZdeaQMDjsSmIRXHB@bombadil.infradead.org>
Message-ID: <ZdedcU9NRJ8-ws33@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
From: Yosry Ahmed <yosryahmed@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Hugh Dickins <hughd@google.com>, David Howells <dhowells@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	lsf-pc@lists.linux-foundation.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 22, 2024 at 11:02:24AM -0800, Luis Chamberlain wrote:
> On Fri, Feb 02, 2024 at 02:29:40PM +0000, Matthew Wilcox wrote:
> > So my modest proposal is that we completely rearchitect how we handle
> > swap.  Instead of putting swp entries in the page tables (and in shmem's
> > case in the page cache), we turn swap into an (object, offset) lookup
> > (just like a filesystem).  That means that each anon_vma becomes its
> > own swap object and each shmem inode becomes its own swap object.
> > The swap system can then borrow techniques from whichever filesystem
> > it likes to do (object, offset, length) -> n x (device, block) mappings.
> 
> What happened to Yosry or Chris's last year's pony [0]? In order to try

For me, I unfortunately got occuppied with other projects and don't have
the bandwidth to work on it for now :/

I don't want to put anyone on the spot, but I think Nhat may have been
thinking about pursuing a version of this at some point.

> to take a stab at this we started with adding large folios to tmpfs,
> which Daniel Gomez has taken on, as its a simple filesystem and with
> large folios can enable us to easily test large folio swap support too.
> Daniel first tried fixing lseek issue with huge pages [1] and on top of
> that he has patches (a new RFC not posted yet) which do add large folios
> support to tmpfs. Hugh has noted the lskeek changes are incorrect and
> suggested instead a fix for the failed tests in fstests. If we get
> agreement on Hugh's approach then we have a step forward with tmpfs and
> later we hope this will make it easier to test swap changes.
> 
> Its probably then a good time to ask, do we have a list of tests for
> swap to ensure we don't break things if we add large folio support?
> We can at least start with a good baseline of tests for that.
> 
> [0] https://lwn.net/Articles/932077/
> [1] https://lkml.kernel.org/r/20240209142901.126894-1-da.gomez@samsung.com
> 
>   Luis

