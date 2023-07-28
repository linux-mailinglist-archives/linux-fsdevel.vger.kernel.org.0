Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6860B76774A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 22:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjG1U5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 16:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjG1U5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6792D35B0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690577821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ImASEVOQ1lkEHYLY3EzvNPddiQfg3hTTCaPO2f4rNg=;
        b=RhsHT31rvxtEi3pykaKYddQjapgyxr33EhTo6Mn7WCejnUXOrOMsqoT94t1y7J/0ITAR2o
        +wdia4mvnDLkZwsyUtiAPXdnzu54MfPOr8ViVEPWMaSOILr2heVl259pyXSsp6jQcb78e1
        +puclU9TvcDYwiVMdjluQB086FPjjfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-TwcuaV4lOEWLHYfo_bTMow-1; Fri, 28 Jul 2023 16:56:57 -0400
X-MC-Unique: TwcuaV4lOEWLHYfo_bTMow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E66228030AC;
        Fri, 28 Jul 2023 20:56:56 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C8ADF77D3;
        Fri, 28 Jul 2023 20:56:56 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 5C43E4018E662; Fri, 28 Jul 2023 16:35:40 -0300 (-03)
Date:   Fri, 28 Jul 2023 16:35:40 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christian Brauner <brauner@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH] fs/buffer.c: disable per-CPU buffer_head cache for
 isolated CPUs
Message-ID: <ZMQYjM1mqPWnq0sW@tpad>
References: <ZJtBrybavtb1x45V@tpad>
 <ZMEuPoKQ0cb+iMtl@tpad>
 <20230727-obsiegen-gelandet-641048c042f4@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727-obsiegen-gelandet-641048c042f4@brauner>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Thu, Jul 27, 2023 at 11:18:11AM +0200, Christian Brauner wrote:
> On Wed, Jul 26, 2023 at 11:31:26AM -0300, Marcelo Tosatti wrote:
> > 
> > Ping, apparently there is no objection to this patch...
> > 
> > Christian, what is the preferred tree for integration?
> 
> It'd be good if we could get an Ack from someone familiar with isolated
> cpus for this; or just in general from someone who can ack this.

Frederic? 

