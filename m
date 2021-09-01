Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692F43FD47A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 09:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbhIAHgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 03:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242556AbhIAHgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:36:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A5DC061575;
        Wed,  1 Sep 2021 00:35:20 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id z5so3418063ybj.2;
        Wed, 01 Sep 2021 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ss4FzlPtnVLRv0fqBuwBlG8fQGDQUymwfyyxVn4e3sk=;
        b=ubY+ha8xta8St2WWD+fhlkbjRwCDrnFvLSzM1q1KbyQyEI5Mf634Is0cQN/sU2OsCg
         Xx0FSPFFptEHW9p4NL1+JVKHxfM7dPl0KB2+5tYjEVoe/+ISps84EeyOdRZFN9B4ubOC
         Rf1INJfBaYF1dBj9Y3OuGUfX64J3GIEF2U7rEIJe3iLil3WjzLgeG9cnbSiIfEEMRKT2
         k7o4o/4Pwg8gGud7CvY5Nkp0OGHMT7H4vnbXnkEROc6OzyxuQbTJVtLk4sJZpYp1C6FJ
         PTehxRAa05WdjtfRKLN477y5DWuGgRA6y7qVIKFJTujuAXwqPoS/A6oJFJjM1RROkpL6
         ZuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ss4FzlPtnVLRv0fqBuwBlG8fQGDQUymwfyyxVn4e3sk=;
        b=ILct5qGL2gG3EtDo/fU2mrCd4p2ADejjqkYJeCM6nRAfu5+YeLc8htIUEyhXqvvKEy
         WQXe1tXD4DDmtzp+QVaWn9gHwBoMxw8NwhXVRJizCWmoG7rIWWY7ODXjy+ATxDMphC45
         AaGzHrhOrIG+QHBq+sib0OQSamZ2X+/DSvj4RGdA2AutFvj2VJQEcnu0PCsGtO+t4bwl
         /SI1Tfe92RcO4cnbnjpYQoDC2cC2HyhGulEei6AuqZtZtrURxOH0bGs4fwU/QIcYj/WU
         FPULe946Zj+h2XNvaXoM78149DgtjMHNe0j/frQAQyUA7r79S43xgYyVyiiJJMLfUDkG
         +5Dg==
X-Gm-Message-State: AOAM532UpE5CKZc5tfuDzhyYuYbu/n9N9Ii52ktXfG6mhKFFtge/KVdP
        5lyLzdwcOpWR9YduGtUNi9MMCoDAiGEXqtgbfLA=
X-Google-Smtp-Source: ABdhPJz6HIU9AJorHC90VmNYAoTf6aJ/MtRF8R4xrzSXECYEBIw0NhYvhf0Y3q4GzF0tUnMo3vb82MpTV+cYvHdtIHI=
X-Received: by 2002:a25:c005:: with SMTP id c5mr33638480ybf.168.1630481719475;
 Wed, 01 Sep 2021 00:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210901001341.79887-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20210901001341.79887-1-stephen.s.brennan@oracle.com>
From:   Dmitry Kadashev <dkadashev@gmail.com>
Date:   Wed, 1 Sep 2021 14:35:08 +0700
Message-ID: <CAOKbgA49wFL3+-QAQ+DEnNVzCjYcN0qmnVHGo1x=eXeyzNxvsw@mail.gmail.com>
Subject: Re: [PATCH] namei: Fix use after free in kern_path_locked
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 1, 2021 at 7:13 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> In 0ee50b47532a ("namei: change filename_parentat() calling
> conventions"), filename_parentat() was made to always put the struct
> filename before returning, and kern_path_locked() was migrated to this
> calling convention. However, kern_path_locked() uses the "last"
> parameter to lookup and potentially create a new dentry. The last
> parameter contains the last component of the path and points within the
> filename, which was recently freed at the end of filename_parentat().
> Thus, when kern_path_locked() calls __lookup_hash(), it is using the
> filename after it has already been freed.
>
> To avoid this, switch back to __filename_parentat() and place a putname
> at the end of the function, once all uses are completed.

Ouch. Thanks for taking care of this, Stephen. I guess
filename_parentat() should be killed, since kern_path_locked() was the
only place it's used in and it always results in danging "last",
provoking bugs just like this one. I can send a patch on top of this if
you prefer.

-- 
Dmitry
