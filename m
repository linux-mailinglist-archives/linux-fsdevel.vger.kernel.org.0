Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FA5737800
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 01:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFTXmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 19:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTXmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:42:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09A6C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 16:41:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6686c74183cso3130494b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687304518; x=1689896518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwV71q09RIOHN6xMbENuZdYxU7Tu6EH6mk+oTK5FNIg=;
        b=nLeERe0shJSmrwEWL570fnmp0Z1gNYr6TYzkj+1pnAV2QJAtsje8AthfWAFEuS2EBl
         EOlHaaIiYbDXEKvnCjSm9eWYmy37YtzE9+2fZY06lQAkMlybSZfXDxQODZUQmWpnf46t
         QdFDvSYVXDcyh8Bh2rfXFmYxtNMxz5gHdiR5inQ3+3tI/XnzZ2SowpKNG9ypXYhT9hOY
         vYyuwZHBWx37hU8o4XXKuR7lHCXdlBMs7epsq9M2pwZoN+io3zooPjSoWAJhdO04hUKL
         o5Wfy6870N4/SYciM0fC84PZuMPGX9C7NCCtcWAMLO8d8kg8LKpkGxQ8g0CYficNw7ea
         XB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687304518; x=1689896518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwV71q09RIOHN6xMbENuZdYxU7Tu6EH6mk+oTK5FNIg=;
        b=XEXyfp0TmJXHUwosvislmIWci24xKov/y1iNVIhAqtbFH/aPIaIEvzXFc0rFieFg7r
         NrnoO9quW/9rjXJ4N7D0ZB3XR51oK3cFVFahHn+pW6/J4PDL9KQCXwTtxxAs4Gf91sGo
         jEGGPt7NqD1pXp/A3oFZs1ZNBRR0wF1O3acv7m/vO+isaDPwTIlll3pj6vE5xpAz7SNw
         ncml2gCwe7gdJy/MFqGsPQIVMd8/l5T7L/3AdS2iYjyrunFO13+YtHn2WXtH6iOSc2vf
         S944pgnCXCkodjZq3qeGNSVEHoMtpORSmMJUV2JTnidBg0WO3HFn+2dHHjEYZ+Ulx705
         asLQ==
X-Gm-Message-State: AC+VfDztJmyE457HooXorY5Qapoh9AdT1ogeiScRtTNfVG2wo9btX1vb
        AqzOqVo6GWI6kUbZbPhbfrzDaA==
X-Google-Smtp-Source: ACHHUZ7F/Y1Y1uettZKpgaOmtxePdElYiIROFm9z032krzzDuWZGu1RH1iXiAUWUcV+6LWRwBIsCow==
X-Received: by 2002:aa7:8894:0:b0:663:78e6:6d0a with SMTP id z20-20020aa78894000000b0066378e66d0amr18570225pfe.7.1687304518195;
        Tue, 20 Jun 2023 16:41:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7810f000000b00667d0ffd48dsm1764098pfi.122.2023.06.20.16.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 16:41:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qBkyw-00EEgt-2c;
        Wed, 21 Jun 2023 09:41:54 +1000
Date:   Wed, 21 Jun 2023 09:41:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3] fs: Provide helpers for manipulating
 sb->s_readonly_remount
Message-ID: <ZJI5QrX+Op3zJkIs@dread.disaster.area>
References: <20230620112832.5158-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620112832.5158-1-jack@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:28:32PM +0200, Jan Kara wrote:
> Provide helpers to set and clear sb->s_readonly_remount including
> appropriate memory barriers. Also use this opportunity to document what
> the barriers pair with and why they are needed.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/internal.h      | 41 +++++++++++++++++++++++++++++++++++++++++
>  fs/namespace.c     | 25 ++++++++++++++++---------
>  fs/super.c         | 17 ++++++-----------
>  include/linux/fs.h |  2 +-
>  4 files changed, 64 insertions(+), 21 deletions(-)

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
