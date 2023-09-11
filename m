Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD13779A0E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Sep 2023 03:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjIKBFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 21:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjIKBFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 21:05:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5DE1A5
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 18:05:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-268bc714ce0so3472168a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 18:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694394313; x=1694999113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGsb5tA6YviorNgYPYAcuSq2xr/+oYqZlEkB4PA46Ig=;
        b=siTFZYaAlbN8ZHintoicJOHMa37bp8u47jZMJUZJ5rWp5aHpA0vAYOSuW1QVSl1Vde
         2qJL5dDToGxbISUsikddeOrtLu0rUiDd4R81OLRTo9WRxghmN7TDKJhtzzeJo+Q+Pk60
         eJOgFsuMQCoqmw+a/zVeV51lY9jNLcWT5WQlxGIggpYmOf+NOEc3sPgSDe8KFquv7NBF
         /tsqlXAZYBFZubpzcColK0ZP2CgF+vVipCExJwVnkAYvjOa85cu8heCP0mH4nAQdkhRb
         mKa7Wh1dZknMDdPa+FT/4F+8ehSm0NurZWZyxsoiYYvbtrkuQnyjsQ8tNRgBuRpsNzQn
         cXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694394313; x=1694999113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGsb5tA6YviorNgYPYAcuSq2xr/+oYqZlEkB4PA46Ig=;
        b=k9/Z0fNwENHg3VG09zafPc0qepZX6QXCpwWYYtd1/zCaYHeiIZJQIgt1zmXxwkxSR/
         fY0rsif9SvT1uigtfuxnMw7+pOzF7waSM6f1Yav298GQdL/ecgz9z6cw9Ns/IGDS+TJP
         zFDybIyiOqOONcqgfHIWngtA3OsqyQfhC1g20jy6oXiOxoM1OFRWx+OQDQQrzUpLrALw
         hrYFcQan7MTJxJ4BbnlKR7PhQKhjZpQ6lIbYwR/x71hu72A66omB6JNzZT838wD8usec
         MoBcOfrIzQNK9Ar3jJePclp9IaCxP3yH+/y2Oks4YyyXJqG5MwQFbYIAwRLbXV1z+0wz
         mPbA==
X-Gm-Message-State: AOJu0YxWSQDNADkKOLSiS2GXpypLilJtpdDa8bLnS5/AVOUL+BfYb/um
        3RcrsJpgV3yHRbJ6YlMmQgJqhw==
X-Google-Smtp-Source: AGHT+IEkW6xGC3kWXEa6X9EHtzzFluPS/ng0ICT4L0VFLSr3f08T6/z/BrKseFYgb260beyu2Eyv1A==
X-Received: by 2002:a17:90a:c082:b0:273:e090:6096 with SMTP id o2-20020a17090ac08200b00273e0906096mr9125516pjs.11.1694394313037;
        Sun, 10 Sep 2023 18:05:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090ae60700b0027360359b70sm6225535pjy.48.2023.09.10.18.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 18:05:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qfVMT-00DZb6-0s;
        Mon, 11 Sep 2023 11:05:09 +1000
Date:   Mon, 11 Sep 2023 11:05:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZP5nxdbazqirMKAA@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <20230909224230.3hm4rqln33qspmma@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909224230.3hm4rqln33qspmma@moria.home.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 09, 2023 at 06:42:30PM -0400, Kent Overstreet wrote:
> On Sat, Sep 09, 2023 at 08:50:39AM -0400, James Bottomley wrote:
> > So why can't we figure out that easier way? What's wrong with trying to
> > figure out if we can do some sort of helper or library set that assists
> > supporting and porting older filesystems. If we can do that it will not
> > only make the job of an old fs maintainer a lot easier, but it might
> > just provide the stepping stones we need to encourage more people climb
> > up into the modern VFS world.
> 
> What if we could run our existing filesystem code in userspace?

You mean like lklfuse already enables?

https://github.com/lkl/linux

Looks like the upstream repo is currently based on 6.1, so there's
already a mechanism to use relatively recent kernel filesystem
implementations as a FUSE filesystem without needed to support a
userspace code base....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
