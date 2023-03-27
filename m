Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B106CA16C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 12:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjC0K3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 06:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjC0K3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:29:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B309271E;
        Mon, 27 Mar 2023 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tF0A6gPnjgSJKB/3SYCSn3c7k/b+DgLpdgiqBRe+Yj0=; b=ZZfi5k2pJ2D6mMoZ7LpjbRXf04
        msUkZ1tQv/yQfPhdnhBQv00igXRLWjYtXskDNqZnYOKbENbf+IT0G0tokyPFM8MYa+pWOBT8WllIG
        7veBOe74WFTQbrnPgzaFN4Iri0N9LqaMuKT+TwSyWcPRIGdghvgHfDcwSrkZSirq8Xecy80apWig4
        ZNVYxf98Zga46RdyC7ai1gthLjl8nKYpE+Ieu+vOLlw3+/5fFYFnFqLY9Ila2HwZBVb+7EpPchki3
        gkkL3T62eAdSyu4YcJEIKpGksJ3iLQ7O0Eemtay94VShV8pAbyA5CvLKOmc9/L8mvQr1bzbeN2jBv
        2+vuVQag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgk5l-0069jl-2j;
        Mon, 27 Mar 2023 10:28:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B8F7300289;
        Mon, 27 Mar 2023 12:28:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FF3B202F7F75; Mon, 27 Mar 2023 12:28:45 +0200 (CEST)
Date:   Mon, 27 Mar 2023 12:28:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Dharmendra Singh <dsingh@ddn.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fuse uring / wake_up on the same core
Message-ID: <20230327102845.GB7701@hirez.programming.kicks-ass.net>
References: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 07:50:12PM +0000, Bernd Schubert wrote:

> With the fuse-uring patches that part is basically solved - the waitq 
> that that thread is about is not used anymore. But as per above, 
> remaining is the waitq of the incoming workq (not mentioned in the 
> thread above). As I wrote, I have tried
> __wake_up_sync((x), TASK_NORMAL), but it does not make a difference for 
> me - similar to Miklos' testing before. I have also tried struct 
> completion / swait - does not make a difference either.
> I can see task_struct has wake_cpu, but there doesn't seem to be a good 
> interface to set it.
> 
> Any ideas?

Does the stuff from:

  https://lkml.kernel.org/r/20230308073201.3102738-1-avagin@google.com

work for you?
