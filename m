Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD17A0BC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbjINRaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbjINRaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:30:13 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B264D1FFA
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 10:30:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41512bfdcfbso7303731cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1694712609; x=1695317409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I31XaMCQ5fidI/zzBKy/0XkFbGUxcn2ZzoJ135kAf/8=;
        b=gBkL89Uq9pj4+aVM1Yq0nqSo/yNNQjFj2WoN0py+XKU/wiU6H9QTwJRXTX6whFXKfd
         Wx8TlGZaRsbr0cU52XgX/tVokCAifslHw99K0htu46M7ZPbi9t6kKT7EbrHR4S1eZyzP
         W53j+JVG9l5NlaP8vTAESayN78NPZDDTqPDtrIIaSUULOZ0VL1CFuldONoMUghPU8A1I
         2HjXkG6P5oBoUeJsDVbiqGC4MEpHNJg/oJHeTWDcF9+hHZ/1yjIYjwobmxcHSPTtj2qF
         sKgXQwBXzdgyS2TYZ+ZytQMq3z4QaEHrNEgrk/vfk0e6oDM1SCRhbHrT5od53njWVOJA
         CJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694712609; x=1695317409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I31XaMCQ5fidI/zzBKy/0XkFbGUxcn2ZzoJ135kAf/8=;
        b=KjdoY0ttMUlKpOh1FbacWOvDuK/Iq2eCrQKXbXB4AthHvZg4WlssAPxrjWnwVQztEL
         xT+PwXV6k1TxFssiheb6LEnp92Ea1ud43bY5tXAPRhwhGzxP0CzlmpgITPqOL4rU6Z8z
         85iqwHdflo9RCyM4P6GGLwB4CIJdsan61QJsJuGtlSwI40mnuFbkhfst7GAOzDohnBKi
         gR8deBi+PHr7ghk/119pofc2ecO0tb5HQL/T//QL0J3PT56uiB99YUxT32ZYgPM7kFFU
         E7U2QHXcxHO3IZfY/GeDqNfBRVLY9VwDW6AkDrGUjevIfEP9XHEFbF8Z3eSvosox2wtP
         IshQ==
X-Gm-Message-State: AOJu0YzoQMVtxwN8dCkruizSoCl/K22DjxxDhUlcIVvN58QNLBHHXs19
        dgG14scraYd6jIK/m+8ke0oK5A==
X-Google-Smtp-Source: AGHT+IEZpNq9+bM534RNnPItdwa/uFVlhol4qk5oB7qtDxuGfxTmRZVZcUzIC/90jxY+USlXgkJV4g==
X-Received: by 2002:a0c:e492:0:b0:61f:ace6:e94e with SMTP id n18-20020a0ce492000000b0061face6e94emr6319246qvl.0.1694712608830;
        Thu, 14 Sep 2023 10:30:08 -0700 (PDT)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id e12-20020ad4418c000000b00647386a3234sm249631qvp.85.2023.09.14.10.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 10:30:08 -0700 (PDT)
Date:   Thu, 14 Sep 2023 13:30:05 -0400
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Ungerer <gerg@uclinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: Re: [PATCH] proc: nommu: /proc/<pid>/maps: release mmap read lock
Message-ID: <ZQNDHXyl8c6YZ4Q6@dell-precision-5540>
References: <20230914163019.4050530-2-ben.wolsieffer@hefring.com>
 <20230914100203.e5905ee145b7cb580c8df9c4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914100203.e5905ee145b7cb580c8df9c4@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:02:03AM -0700, Andrew Morton wrote:
> On Thu, 14 Sep 2023 12:30:20 -0400 Ben Wolsieffer <ben.wolsieffer@hefring.com> wrote:
> 
> > The no-MMU implementation of /proc/<pid>/map doesn't normally release
> > the mmap read lock, because it uses !IS_ERR_OR_NULL(_vml) to determine
> > whether to release the lock. Since _vml is NULL when the end of the
> > mappings is reached, the lock is not released.
> > 
> 
> Thanks.  Is this bug demonstrable from userspace?  If so, how?

Yes, run "cat /proc/1/maps" twice. You should observe that the
second run hangs.
