Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C748A5BB9E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Sep 2022 20:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIQScT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Sep 2022 14:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIQScQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Sep 2022 14:32:16 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A797D2CCBD
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 11:32:15 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3378303138bso296184187b3.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ddmg5bRCAtXyxOkY+3dyLtIUd+SwkxVDg5Z+QEuBU9w=;
        b=lcwodcX5v2bqj7Qs6vsBtAbOPk+cjgDXQ4hiyf44oGWS8dLoCDVWheuZdnNGu7eg1u
         nvizPsQUjW/BmgPIj7B9Jr0ScoMzbN2JnYV3ZuWsVuTwLSu4+BWKQymWM5SI4afLlbeU
         YphL4O1TBH8aniK9Hz/cYYXW+cBIXLPUpHpLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ddmg5bRCAtXyxOkY+3dyLtIUd+SwkxVDg5Z+QEuBU9w=;
        b=QFxBxm9+gKty5CIearMw+I7TLYq+eSaQWk0odQ8iOGCujhKOI60iBLpq41pu/VGr5l
         NhpTmyVcuXr6dM60TnQCeAK3WDvwK8tTOpT4AgWrVF5a1wGGSw0s8TWtwHFaJP7vFm/P
         4XkO+V7hO3G+rV/R0XEySNu0EfUoSTm3xdLGkbGLYMIIy1m7Y4IXSRSnARPfldTrNFiP
         rCzEnQg5nyhvfvPcmyvFr01ZI4e6kDu2BJKHMdJQrV44CnWsqPmMKAWiKqCHwPa4xkfh
         BHgZTr6WQSl2IdUPwhYYfMh9mHLH7W1dimjrRXLuBDF+jfHoQ2VL9YKMnhA6yGjWH+j4
         YlnA==
X-Gm-Message-State: ACrzQf2UKlWyOM6GyRNOC0P65dg9ek72dm4z1DNAGF1fMvZFz3j/5kqX
        10r1KrGdzEOjNqxGwIKyOuz83AebAJR8vGIhzmo7oA==
X-Google-Smtp-Source: AMsMyM5hK1ssqE4TGQuqJXjL0whrUXobHN7ZUamDD3cTgvNnS50Wnk1qlCH7crY/WT6AesGcNm6+V+om8yX/lPv7LAs=
X-Received: by 2002:a0d:e80b:0:b0:345:1c88:2885 with SMTP id
 r11-20020a0de80b000000b003451c882885mr8675871ywe.322.1663439534933; Sat, 17
 Sep 2022 11:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220916230853.49056-1-ivan@cloudflare.com> <YyXoVxS5+FUA+vat@mit.edu>
In-Reply-To: <YyXoVxS5+FUA+vat@mit.edu>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Sat, 17 Sep 2022 11:32:04 -0700
Message-ID: <CABWYdi0BF4TmwcNhwszUJ=aseOiPYVo3cR1oh9RK=6AXAxKYmQ@mail.gmail.com>
Subject: Re: [RFC] proc: report open files as size in stat() for /proc/pid/fd
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 17, 2022 at 8:31 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Sep 16, 2022 at 04:08:52PM -0700, Ivan Babrou wrote:
> > We considered putting the number of open files in /proc/pid/stat.
> > Unfortunately, counting the number of fds involves iterating the fdtable,
> > which means that it might slow down /proc/pid/stat for processes
> > with many open files. Instead we opted to put this info in /proc/pid/fd
> > as a size member of the stat syscall result. Previously the reported
> > number was zero, so there's very little risk of breaking anything,
> > while still providing a somewhat logical way to count the open files.
>
> Instead of using the st_size of /proc/<pid>/fd, why not return that
> value in st_nlink?  /proc/<pid>/fd is a directory, so having st_nlinks
> return number of fd's plus 2 (for . and ..) would be much more natural.

From what I see, st_nlinks is used for the number of subdirectories
and it doesn't include files. In /proc/fd we only have files (well,
symlinks really). I'm still happy to use that instead if that's
preferred.
