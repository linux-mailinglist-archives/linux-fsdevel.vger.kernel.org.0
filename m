Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853EE5B6B91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 12:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiIMK02 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 06:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiIMK0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326D5C37E
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 03:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663064767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=haJLEkgrl6AF0f2+tq8m7Wz5y9BoDUUF75cEpjza7qM=;
        b=QuFqQWu0jUmY0HnWSN+FDD4ozqNFL8cViZ8/z/jl49fWYGa1OUoJ2DMtng0q9evglE1aTC
        V24nRm3COcjl0pgzIUA7yQwe/gemdj/81oJU9qDArusO3MFfxLqOk/q+Xlo4UNnxgjRXNJ
        LT9IN98M1NFeDtzg2k4TdxyEX9Syj6M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635--orak3MgMIiwkt3zC2ek5w-1; Tue, 13 Sep 2022 06:26:04 -0400
X-MC-Unique: -orak3MgMIiwkt3zC2ek5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCD048037AC;
        Tue, 13 Sep 2022 10:26:03 +0000 (UTC)
Received: from localhost (ovpn-13-136.pek2.redhat.com [10.72.13.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 174751121314;
        Tue, 13 Sep 2022 10:26:02 +0000 (UTC)
Date:   Tue, 13 Sep 2022 18:25:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Jianglei Nie <niejianglei2021@163.com>
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix potential memory leak in vmcore_init()
Message-ID: <YyBat53TZUK9trX/@MiWiFi-R3L-srv>
References: <20220913062501.82546-1-niejianglei2021@163.com>
 <YyAkpQNWXrkMGdYr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyAkpQNWXrkMGdYr@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/13/22 at 07:35am, Matthew Wilcox wrote:
> On Tue, Sep 13, 2022 at 02:25:01PM +0800, Jianglei Nie wrote:
> >  	}
> > -	elfcorehdr_free(elfcorehdr_addr);
> >  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
> >  
> >  	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
> >  	if (proc_vmcore)
> >  		proc_vmcore->size = vmcore_size;
> > -	return 0;
> > +
> > +fail:
> > +	elfcorehdr_free(elfcorehdr_addr);
> > +	return rc;
> >  }
> 
> Did you test this?  It looks like you now call
> elfcorehdr_free(ELFCORE_ADDR_ERR) if 'rc' is 0.

Right, that will cause problem. It's my fault since I suggested
the current change.

Jianglei, please use your v1 change and post again. Sorry for the
incorrect suggestion.

