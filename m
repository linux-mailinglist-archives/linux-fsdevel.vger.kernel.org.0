Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C7650AF74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 07:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348873AbiDVFR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 01:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444113AbiDVFRn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:17:43 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA354E39F;
        Thu, 21 Apr 2022 22:14:51 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j9so5133102qkg.1;
        Thu, 21 Apr 2022 22:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UzSUlOF8KDoR9NJ195sba6wlXvE2bZq/DNakp665B3U=;
        b=Q3BsiOHfa13lTsLovJcciqc6FjUgOUDC6KinPy12Ag9ltwCqDBD+ZtMyPz7wLhlV/8
         ZSiuFocRSyixr8LtHibcNXL12OMlM6+C7cIB8IHE+8zbnjxJYWSYK7aOVbca29PvxhUg
         OALWJgRDhEdhGCUWMmm7K04X+UpW3SqSp2i6D1ZSvcvzxOKadXybwn/M0YRS7gm03S9e
         GsZyBjkC9UYraiYlo71nunqLJ7Fi4trfrovdMPt2uVbYTmFjfmQE23K0EAzmBRGQlebk
         1NeAVrDNVx3PUN96KHTeyvB7T+SrOaE/tL0dYyXuVNmKxy1CN5TOSHe7lICCEHthNk4u
         SW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UzSUlOF8KDoR9NJ195sba6wlXvE2bZq/DNakp665B3U=;
        b=7IYF54qeh+2svRe4A8GX1X4PSMH2B9ZQ451Lbbg46CoLKUnMyy7wk9zm+9A+WFmeHQ
         rlO52wA0WCp0BovQNC0s4Ak6hdRlXBZELjUbwF7fHOfbccKaebrkfCzlrcd5bzYjLrVj
         WF6PIlGxAPxFRv0hOEzDDTEgpmlJCuigPggb+5ZEsFEqYgQR0YzfrH48vKEQGfd0GHyb
         Y0Zro2ybMvmZrF/7pTpJIjPbdAwWsYtY++MVdCzj9zqJx+Ck/sPkfqGGs8JK5btRfc20
         GbKYTVOEr6Y8Sqtc9ANtW6RiReczMKnw2eXio1yFLVwXB2ZL6pi4AF6TQbvz55aIslwF
         8nIQ==
X-Gm-Message-State: AOAM533Al9bDk7XGajwWpHgKQUfTTo9XZHem9nViv9b8+Hy6TnK8PWVN
        Ob8VpH6zBlLKsOoSoFTSKgpmsttC4nZT
X-Google-Smtp-Source: ABdhPJyEkvdj189+G4fcRUz/WVIjCgUY6uQFAlInHCF4wn3U7HrpUYbtDEIKZMQg+DyB/6RApN2zdA==
X-Received: by 2002:a05:620a:13bb:b0:69e:8b7c:1037 with SMTP id m27-20020a05620a13bb00b0069e8b7c1037mr1659008qki.703.1650604490631;
        Thu, 21 Apr 2022 22:14:50 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id u11-20020a05622a14cb00b002e1fd9dce3dsm690671qtx.60.2022.04.21.22.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 22:14:50 -0700 (PDT)
Date:   Fri, 22 Apr 2022 01:14:48 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev, rostedt@goodmis.org
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <YmI5yA1LrYrTg8pB@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <20220422042017.GA9946@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422042017.GA9946@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 06:20:17AM +0200, Christoph Hellwig wrote:
> I still see absolutel no reason to bloat the kernel with a duplicate
> of the existing seq_buf functionality.  Please use that and improve it
> where needed for your use case.

Christoph, you have no problem making more work for me but I can't even get you
to look at the bugs you introuduce in your refactorings that I report to you.

Still waiting on you to look at oops you introduced in bio_copy_data_iter...
