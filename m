Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B193AF702
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 22:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFUUzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhFUUzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 16:55:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A6DC06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 13:53:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d12so586829pgd.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=yJ0XnEZfYvv5DOEqVxVuy0qZw0MfR5QdbWgvAfHk919WufEZire6sONE5W5FX1eIQd
         rf+boSQlumqkNCvn4iUd1koxzTjMNrVRN4YvetjXuhua8WR+h5UQduE/DUO1dJkgxtre
         A3i2TzTu+LI5quoOugbl7xAOoOftzrT/v8TkQ0TPq9awvk5q+rCn3z39Ncfn7M2oawVW
         /hGxh49sdCZMbq5yIn2E0mFWmRH9O5mtnPBMc71kxhYlIXxVLHaIgPWs7tAhBawHt+5K
         1zHmi7YeFDlPeiqfro9J7/Xtk/LtavFNJ2LRUsE75I9JEht0lQTwQOTh9gTi8jhUD/MY
         FW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=pjP5b2u27uh7HHt2QUWfLjQt8dcCuIOf+7M4ZtyXabydSXDYUuiaFYyanoYC2YV27w
         sUBdJTSRcGGi91Vxgu41bsHFZTP/OLzCnUjD3yd4kaKgQ1zL1NNiDa96J94AshJfYL14
         ZADZLfGYKrTRKjok6ouEyeNvzXtfSoIVjvYKsma7BFbOUiw2H/AGpIiJqHs9ctZbuZJW
         LxKrpieVi5zIzRgs4741qlWge+GU1qOU0uNjvH2fO2FV5YC9EzVvicgE6ja1EKcRclW/
         HOM+lRV/cQ5SfpJGMy4TnHZrLiXavau6drm3J/LBOgQ/IADV97Jb2mxWMI6O3vuhM6oY
         JQMQ==
X-Gm-Message-State: AOAM53269gzQvstcCClssv03n8peydqHow/rALy2+ORsYdw7tEuSkl1M
        bZIhrL1dl0W2tnrEfZxqTYjegg==
X-Google-Smtp-Source: ABdhPJzYnGrp4Ff99F1duwMgIJUssY3ir1PyUwMP1oFAI0PMME36iyMItTuY6udB9lZoICLlj+ONZA==
X-Received: by 2002:a63:1460:: with SMTP id 32mr366929pgu.163.1624308813134;
        Mon, 21 Jun 2021 13:53:33 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:96f])
        by smtp.gmail.com with ESMTPSA id y15sm98431pji.47.2021.06.21.13.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:53:32 -0700 (PDT)
Date:   Mon, 21 Jun 2021 13:53:31 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YND8S9b5SiTVoM/k@relinquished.localdomain>
References: <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
 <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
 <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain>
 <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain>
 <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YND6jOrku2JDgqjt@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


