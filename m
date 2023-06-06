Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A9723C93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 11:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjFFJJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 05:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjFFJJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:09:19 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01671100;
        Tue,  6 Jun 2023 02:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686042506; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=YtpdOb/AzYZrYY3GpszrkqzLl0bfDd9HahfTMQCufVTElUpLJnoB0d2tp34gduW59lNYm1Ws6jrB0qGhovEkywGHlxwuMf5s9kYrIGkUJMYsVz9/mpJCMAuTVgum+zswcsJyjXgN+UvKQSdGQbb0Hbv388uW7H+Z8QuQEfZikxA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1686042506; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=wxe0GhnNp19oT1s2yGlZCmuUW7SIjjh4ZIOmxejbeuU=; 
        b=R/RMZwuD/5aBWoNCbMu6Np/n+EoL33pJ5gNwTLunPlhhv3OAAHqFRFcejZAdeUn5hBHssGHK8X7BmbdtO2nvLrFCfYK1hxkEm0yJUIEMnDCPAeDozImOqzgmXHMX8KuHYLyTNQXHJawMDUEzohYl12PWtqYa1OgIR71RD9iXjew=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686042506;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=wxe0GhnNp19oT1s2yGlZCmuUW7SIjjh4ZIOmxejbeuU=;
        b=QCnKJAgafRpGLe0HKNNopHvk0tMxdBrhp1Q9u2fr5O40qI5ssScT8gkjgRLtH6BB
        5Qztp/wX7W0sUWRSk4j9u6qTS1zii33rBA1OOTTsQrGItQ2NJ5MqGLpiUgcXYnV+OMq
        Wgkro9qNw2bwvtCnVXKEOxEEecUn+z393imBo4rs=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1686042494469601.5259406750127; Tue, 6 Jun 2023 14:38:14 +0530 (IST)
Date:   Tue, 06 Jun 2023 14:38:14 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Christian Brauner" <brauner@kernel.org>
Cc:     "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "stable" <stable@vger.kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "David Disseldorp" <ddiss@suse.de>,
        "Nick Alcock" <nick.alcock@oracle.com>,
        "David Howells" <dhowells@redhat.com>
Message-ID: <1888ff6c5f5.42ebd67876277.4429544209877292620@siddh.me>
In-Reply-To: <20230606-getaucht-groschen-b2f1be714351@brauner>
References: <20230605143616.640517-1-code@siddh.me> <20230606-getaucht-groschen-b2f1be714351@brauner>
Subject: Re: [PATCH v5] kernel/watch_queue: NULL the dangling *pipe, and use
 it for clear check
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 06 Jun 2023 14:22:49 +0530, Christian Brauner wrote:
> Massaged the commit message a bit and applied David's Ack as requested.
> 
> ---
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.

Thank you!
-- Siddh
