Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126643D3015
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 01:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhGVWdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 18:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhGVWdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 18:33:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA70C061575
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 16:13:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j17-20020a17090aeb11b029017613554465so1341865pjz.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 16:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oeJyFR9Yc7viGXi2IvQIJWjerryexnnphTKxZplc1dY=;
        b=WaLLCa2lQabbxgtevQYcyNgoNokOnNzwb6zx86pUruPPS4fTFCI90sGJ35B5vPaJUf
         9neU+bvC/gv5aOMOzoVPv0pymtUaILiBQQxcJQPvN0HJ4Gk8ZulAb0SZfSuGXY8lBYq9
         tVW9YbqMT/6wOwajnsYI59kcy8oOp6S81r/Gy9GYXH/6IlQGLhet//PrZ6tMSwEWbbN8
         /fwl/TifjhIF5rB17dDvRpZbrrGphrVjGzoQF3iDoE8obkNXNPE5svVIZgE6cfsaNNU8
         CKefjRL7tSVdnPy0IBJm3JBzr735A3mV7uWFgo7f7BCh5aBdLsjNUliYENg8d4Lv0YHA
         eLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oeJyFR9Yc7viGXi2IvQIJWjerryexnnphTKxZplc1dY=;
        b=URBBv8fYv1pmqRYirB17CN0ONGh7th01wEn5+87/1IliGN5yMwYTmnYsIZaPvM9k4o
         gjSqtXfT81AapyswZr08zrYXLHDjFoXnLA7svJcfFo2xX8d9k/horCxtevHLhDh79SEY
         XHodG2mFlnqXPfEy/0S2G56zSTXXV4e+Nob14KYYNTyZo1Z9e28WnXIaDQjOiFq7w00F
         plEvkH/t74X1UD3npUfOvB4ffM6xs6SHCKRvsaefg6UY5oppAHKj3j2dtggx9aPonIw/
         h1yk9dzbwDhJX6iMchJs+Fg7C94Q9pnswLA7GzFO/MloOIJoPMCwk/CyNDoXSx4+4edU
         dxNg==
X-Gm-Message-State: AOAM530tNboEMICECxKbnmduVebhK77i7xWhZ6y9QjOZBQC5nTtT4Qow
        1D+iET9G9iQx3LceXSw0PuPDSA==
X-Google-Smtp-Source: ABdhPJzhAKrAy9kErd542XtrvVgy/USk2zlDGiiQ3t1N/bHAKP+iYTkX1JwoeVxMAM9onQDM5zl+NA==
X-Received: by 2002:a17:902:a705:b029:12b:71be:d24e with SMTP id w5-20020a170902a705b029012b71bed24emr1609053plq.29.1626995619910;
        Thu, 22 Jul 2021 16:13:39 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:1e5d:f7bc:71e:c763])
        by smtp.gmail.com with ESMTPSA id n33sm34808101pgm.55.2021.07.22.16.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 16:13:39 -0700 (PDT)
Date:   Fri, 23 Jul 2021 09:13:28 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [bug report] fanotify: fix copy_event_to_user() fid error clean
 up
Message-ID: <YPn7mCNt33rFWjhD@google.com>
References: <20210721125407.GA25822@kili>
 <YPih+xdLAJ2qQ/uW@google.com>
 <CAOQ4uxgLZTTYV9h4SkCwYEm9D+Nd4VX5MbX8e-fUprsLOdPS2w@mail.gmail.com>
 <20210722093142.GU25548@kadam>
 <20210722140103.GZ25548@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722140103.GZ25548@kadam>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 05:01:03PM +0300, Dan Carpenter wrote:
> On Thu, Jul 22, 2021 at 12:31:42PM +0300, Dan Carpenter wrote:
> > Smatch is *supposed* to know about the relationship between those two.
> > The bug is actually that Smatch records in the database that create_fd()
> > always fails.  It's a serious bug, and I'm trying to investigate what's
> > going on and I'm sure that I will fix this before the end of the week.
> 
> I'm testing a Smatch fix for this so hopefully it will pushed in a few
> days.

Great!

Well, do let us know what the outcome is post running the Smatch tests
against the copy_event_to_user() function once again...

I do feel as though shuffling things around isn't necessary. Especially
considering the fact that what is current is correct and as you mentioned
this is a perfect oppurtunity to make the tooling better. :)

/M
