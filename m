Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FD7300E7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 22:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbhAVVFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 16:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730941AbhAVU7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:59:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0FFC061793
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:57:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m5so4654727pjv.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ra2bY9IB522xV23Eugk7PmgYePrcblUWlzmySd0Cyyc=;
        b=nPIrv/PxJkej0AaX/G67VsiC44S4PoFpYmZ/4uEkewsvCiOYAua/TiA226LS94agfK
         Pbubmlpj3q0BjWgTNCio+/SxWMCp1bLh5C4/J0cHl4poaHYklPUc9ovXet95wQ6Z0YKw
         JloNhdrHmlj0Bu2Ny69x0X80jfW98Cj3lYgaHengqVNE2ZdQITyxAZQjX6NA9H+V0erZ
         pi7NaH8b4Ft70WCezcASCHF+zcnvzJPNkjiZPDroL5b54enb7WepuC8SZpVP3XoBTbqF
         W3vGDMFrGkw01vPlnESvnu7HoajqESdTPn1U0j4JYPinYT4C8kcibuGGI5J5X/k2+j9Z
         qseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ra2bY9IB522xV23Eugk7PmgYePrcblUWlzmySd0Cyyc=;
        b=XZph6uFrlrd3HlM5RcBsxdmzVLloZLKSj8mfs+SpXuEFzSp/JB7g7IzB/v6hGmQsEe
         L694PHqgc5ZnfEZ4bxr4p8kHP+4XRq97V7loFMwjm6g5WFHD8qzyfWOhYYktNt0EM9uD
         sr8XDL3JhHa33xmRtT80h9QKMxNzshY0+N+97iyVFNHZD+yEYfXiOLysISyv+OOLuDAf
         lbSPRMJLLMgS2y51V0nysWh6r3dBP71gxMLLXoTrjZ4sDq3ZL6Yl5gwFXvLq+RWtVqFW
         MB1aiXDXAvxAYhjfliZE1WrzfeUnixulZZTP//JcUlMr6CynAe6Jrv/IklNrYUfsPQCJ
         EViA==
X-Gm-Message-State: AOAM5327idIfXGXr8MA7tFLSEtqOQMkl5/u5t0bosDJ9lPsZId+6fNi6
        P8IUJew5SPI6tb6DuxrWiFnccFYqKedgGg==
X-Google-Smtp-Source: ABdhPJykGHqNXYwdYpOh5VuPtfXAMvcdM+WsEFAIkshYbFLTPUVz0m6ITIn/WzY5/X3TGd6tiHcG1Q==
X-Received: by 2002:a17:902:d4c3:b029:de:84a5:aaf2 with SMTP id o3-20020a170902d4c3b02900de84a5aaf2mr132118plg.80.1611349062803;
        Fri, 22 Jan 2021 12:57:42 -0800 (PST)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::703])
        by smtp.gmail.com with ESMTPSA id s187sm9546419pfb.161.2021.01.22.12.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:57:41 -0800 (PST)
Date:   Fri, 22 Jan 2021 12:57:40 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v7 11/15] btrfs: add send stream v2 definitions
Message-ID: <YAs8RIWG708aKJnB@relinquished.localdomain>
References: <cover.1611346574.git.osandov@fb.com>
 <ca550f6e2d6d1e7d79dee6c811638d4da02a56cc.1611346574.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca550f6e2d6d1e7d79dee6c811638d4da02a56cc.1611346574.git.osandov@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please ignore 11-15. I fat fingered format-patch, these are part of the
other series.
