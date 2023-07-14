Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86521753C08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjGNNtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjGNNtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:49:18 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B1E3594
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 06:49:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9a2416b1cso1598860a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689342556; x=1691934556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoTMB/N5t7MHXy0+x2nL5IVn7+MR89ZhD4DHO3A7NsE=;
        b=BhbmMM42r4In5YZeAvg8Y00TGWedQmk791zRvLwAYPocn2gl8mtoupYhvfeGPqeM6v
         WZwwere5jJZOrkdwQeY8i8KEo2uwrjDHNKnOvZw4MWxKAISux6nbR6sKZJqBsTvuVgrJ
         ahBnFsRygE+JjiMs8pN/+ZQzyNlv+Vqj3SdXRiIV8H8WQARf29SlRjkQymESjt7jqYkF
         InN65Jfn4eDPnIDbCiRITv0tJ2FH7gt5Qg41aKnrdqWR21r6/SyL2TGXqTHPqE3/9fK7
         PgL6TW6BBJ8SD2Chsqdi9JhTLuyHMZmzyNNAKOe02uykYgSv70W9kRiFokggl5YT1ATJ
         u07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342556; x=1691934556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoTMB/N5t7MHXy0+x2nL5IVn7+MR89ZhD4DHO3A7NsE=;
        b=h+C96oPnA/QAJlWnDMMtsnyVZpzmBAh5w6hn7JuF8of3jZOAJ/4mgNoeUrUf/3Z9WC
         wsQgIJM3MEYOLyfbj0f1KEQuo8XVJ7dzyVfS2FfEe86d/gQgCSp63XMWG52ex2l2k72S
         ElXOSPJAMngJYmv6J+M/6fzdEzqsHnaz2XJy0GA3Wum9a7SJ0iBA4YHfjeSC8CX5tsI5
         DC3MluEZewSBQO8Ypb0tZ3Ub4/XrJzECGU/d/vJhyND3MxXOJK1yCC4eR8No+AVPNDr9
         EWjUVJR2/aHiSJRHePFsDdnOLp2PbhW0izXGO0RBr0MhZMmjvOq+EQTcmUABEuJ7hESu
         zswg==
X-Gm-Message-State: ABy/qLZ7ezy8loJPn3URciIg1RNdJMsfl1oAUHHRdM1MB5ZFU03uDlGb
        65FPWMLbnT0OkMQ8i4ZavBh5VzCKZmTMpMRr53RSfA==
X-Google-Smtp-Source: APBJJlGlNiux+dTU5oS/hSa+6d7Goi7MnP87WV0F7QUkq/5OkmhxVmH+iYC99ICU8VjYiu5UtWEM4w==
X-Received: by 2002:a05:6358:4402:b0:134:c850:e8c5 with SMTP id z2-20020a056358440200b00134c850e8c5mr6825934rwc.19.1689342555681;
        Fri, 14 Jul 2023 06:49:15 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m67-20020a0dfc46000000b00579e8c7e478sm2309695ywf.43.2023.07.14.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:49:15 -0700 (PDT)
Date:   Fri, 14 Jul 2023 09:49:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: btrfs compressed writeback cleanups
Message-ID: <20230714134914.GD338010@perftesting>
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:31:21PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series is a prequel to another big set of writeback patches, and
> mostly deals with compressed writeback, which does a few things very
> different from other writeback code.  The biggest results are the removal
> of the magic redirtying when handing off to the worker thread, and a fix
> for out of zone active resources handling when using compressed writeback
> on a zoned file system, but mostly it just removes a whole bunch of code.
> 
> Note that the first 5 patches have been out on the btrfs list as
> standalone submissions for a while, but they are included for completeness
> so that this series can be easily applied to the btrfs misc-next tree.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the whole series.  Thanks,

Josef
