Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD031E146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 22:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhBQVXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 16:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhBQVWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:22:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC5C0613D6;
        Wed, 17 Feb 2021 13:22:08 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fa16so59383pjb.1;
        Wed, 17 Feb 2021 13:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sQzaNxAid9QvqVYhihsfh2vWMCoJ27PcKGw8kt1g66I=;
        b=p0QwrOctwd52hexap6KCKB3coo8XhqEMui5DoM+5kapBOCgvyAp7ekJdpeCpkuv7IO
         Kyq/cmtvDejQPhs7UFTwVYQGBE1U+C4HUmKE7W4yGgYjjD5Wv4ozQ7D+kSnc5LrVYTeW
         NvA45IpZf95mwZtcplJBAMyAqh2ftR73lmDJka9nasDdXC2zXNSRlklCdPXnZPoLUVrg
         4VTC1SsTKN4i88U4NYVKpB8ikdmEKhy2ZOLoMyyQFCrbBjzSTISK2fAdTTn0tGMC692s
         Ik9IHq3dovW92AIGU47FexYjZGQyAAwP5VTWHbyxBq2BdjDtKjXIzIF+LlwyQulVCA0N
         0a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sQzaNxAid9QvqVYhihsfh2vWMCoJ27PcKGw8kt1g66I=;
        b=H9U/XrgKaERkHzKXDIpnPUAYtNrQPfbJrFnRnKu5lTGYnUv3TMiIMDJSqldV4CmeYD
         wYL9nGouoy9G+ZPKU3ZO/EWjWqg6rv+TZut4VqnpJkZgfOnq7wrQJa70CrPtcwYE7hdo
         bC87v++sBSNOCLYWAF59Mn0AhHA7o0J8SE5/BAHkIFENsR52h8ScGNxk6zZfAD063npi
         O8CmMj0t9VIgUBsAkr1SEliNuF7qAVersqw/T1lWZ1z009vi1SqT7YEzrVumjEaaKxP7
         Gm8i5lpD3HAeJzfeiWdXbJDWtxA3CsTwHalARa92KqOnogIgyBDjCpVKH6DvMnuiR8xb
         gkyg==
X-Gm-Message-State: AOAM5334LeXS9907V8Ci4FF34CCCiSIw/REipBnqsERwmFcCg0TM56mT
        xC5PfFfrO1f8Xt5v9zeBEO0=
X-Google-Smtp-Source: ABdhPJyneviUq4ugz6XKjWdZ8xrW7jmT9QscfAaiU+m4gfcMOT7KkVass8VqD3YPzLbVH6LFh50zCA==
X-Received: by 2002:a17:902:f54e:b029:e3:5af0:d98f with SMTP id h14-20020a170902f54eb02900e35af0d98fmr920942plf.5.1613596928463;
        Wed, 17 Feb 2021 13:22:08 -0800 (PST)
Received: from google.com ([2620:15c:211:201:157d:8a19:5427:ea9e])
        by smtp.gmail.com with ESMTPSA id 184sm3475254pgi.92.2021.02.17.13.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:22:07 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Feb 2021 13:22:05 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, david@redhat.com, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YC2I/d2DnXRQ7eq3@google.com>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
 <YCzm/3GIy1EJlBi2@dhcp22.suse.cz>
 <YC2BzdHxF0xEdNxH@google.com>
 <20210217211143.GN2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217211143.GN2858050@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 09:11:43PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 17, 2021 at 12:51:25PM -0800, Minchan Kim wrote:
> > I'd like to avoid atomic operation if we could.
> 
> Why do you think that the spinlock is better?
> 

Michal suggested atomic_inc in writeside and atomic_read in readside.
I wanted to avoid atomic operation in readside path.

You are suggesting atomic for writeside and just read(not atomic_read)
in readside?
