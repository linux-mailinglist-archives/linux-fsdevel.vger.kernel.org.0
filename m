Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311B2616467
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 15:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiKBOF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 10:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiKBOFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:05:22 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B6BB1E0
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 07:05:20 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id k4so8867291qkj.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Nov 2022 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4w7wXNmdLV4OtC8nHZb8HB8PhIdAh7iXHyc1XK6rWl4=;
        b=kugntUIpcffoCmxW4Nri7QP0pPhYLjuTwdcsgYlKtz/GcEc2cYXj8pESDHy+lsf0fF
         /Y7mmcyACLqNtwpXsZylVfbK9P3gGeYaL07GcMuGHjT0CioITdka1lKgEn2IS4nHxdBZ
         A+SZ/b2el58rx6gA0UEz7vq9hQvB2DQ9bofEnOuUrhN2IBcStaB6T4AUduEYRABUnPz0
         yq/a29Kk38ICndt/CvWSmk9WPqXU84RU8h+62of1Dhvv+HFaUa77GSVr4fbFzw6zGBbB
         +AL34wPXSQ9EdbKEiiR4XXMO8kWNTHiiBLOSJjgxrJd/mPaQR/qpLJ1HfeervwJCvWZ3
         Qygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w7wXNmdLV4OtC8nHZb8HB8PhIdAh7iXHyc1XK6rWl4=;
        b=rh/al4xKhdwWdNNbPdocr4avFVZb4hvbTYtSZGeovkZouW1mX4PaDJAeJTDsaOUDcf
         0/XZJQKBQZlC/2CBg0ABVaWQyh5aVEX5egckmXbDe37Np/8m6qZdH42wqb8Gb7eUXwPv
         ERjvEIFGLbnmhB/SPCoEI7Bo9/Ai1QbJeq2M8Ou+HlfWyrO1yFRF7m8cCVIzVVPDH9CI
         RMNK4LA6RYySVzfT7CtwP+9nH/863pesQkUxvnGuCe1XGKDARg2J7xXBTPwSeGANOpom
         KBdoj/GnA0abViSQBo9S6wB/j/D0w9igO40Al8Ej2AGHhEbDIbreWMQxNNSoH0tjwPOI
         7ZbA==
X-Gm-Message-State: ACrzQf3vtoNJZhLKmwt7Nwi8dvoiOEhwDs0M6JR4C6f7VtJfvk+qIK1B
        3uTtqmKrR/vNx2vN1yhEcglRGA==
X-Google-Smtp-Source: AMsMyM6MoUNpT50CyMbPPNkrgPiNwcoHd7cSEHtDBeG+CzcG510Wkqtn0bk565Fp9vHcS1tHG+hR9w==
X-Received: by 2002:a05:620a:7ee:b0:6fa:5811:760e with SMTP id k14-20020a05620a07ee00b006fa5811760emr2978345qkk.363.1667397918930;
        Wed, 02 Nov 2022 07:05:18 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id e5-20020ac84905000000b003a5092ed8cdsm6629766qtq.9.2022.11.02.07.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:05:18 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:05:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Sterba <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@meta.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Message-ID: <Y2J5HfQn+XU74ECJ@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
 <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
 <20221026074145.2be5ca09@gandalf.local.home>
 <20221031121912.GY5824@twin.jikos.cz>
 <20221102000022.36df0cc1@rorschach.local.home>
 <20221102062907.GA8619@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102062907.GA8619@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:29:07AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 02, 2022 at 12:00:22AM -0400, Steven Rostedt wrote:
> > It really comes down to how badly do you want Christoph's code?
> 
> Well, Dave has made it clear implicily that he doesn't seem to care about
> it at all through all this.  The painful part is that I need to come up
> with a series to revert all the code that he refused to add the notice
> for, which is quite involved and includes various bug fixes.

Except he hasn't, he's clearly been trying to figure out what the best path
forward is by asking other people and pulling in the TAB.  I don't understand
why you're being so hostile still, clearly we're all trying to work on a
solution so we don't have to have this discussion in the future.  If you don't
want to contribute anymore then that's your choice, but Dave is clearly trying
to work towards a solution that works for everybody, and that includes taking
your copyright notices for your pending contributions.  Thanks,

Josef
