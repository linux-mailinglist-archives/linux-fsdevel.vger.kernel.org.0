Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72142A3384
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgKBTAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKBTAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:00:39 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C90C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:00:39 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j31so3222878qtb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IA1aTtUXt34lnBy33ApahV0yb/qViPXLo1nvZ8GG74Y=;
        b=VJfNJDrdIfL7a3CnO48zdxk1PJm8oezBI/SFzcGlhUUNrXn2TGGOKimYYwFdkqaul/
         GuXsA7qkPoCh40DGs6XgYbv4xwUtAv9y6krMdJDD23G/0awrYRyZtay3d/1Q1vCZ/8kW
         LX2lWDeZaoX1vgJX3afR2wXnz3AE3fkXcRAiia3NoDRP1wJTmseDqMegjJh6Q8AVql/L
         FZLwgSEFgVeRR4d/3f1eML3T/dgMjrWb6SaW3pX6I2AsBeQNxbi7epVodYteqwEoRmYh
         JrEIvQR3m8KPIVL797kSD8U6uQlCz4IX3MCjkP+qoLr2hUelh/Wj5coFAlYS05zHnfZQ
         Mfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IA1aTtUXt34lnBy33ApahV0yb/qViPXLo1nvZ8GG74Y=;
        b=uh8/34R3KGRD6Rw2hTAgljysE6Y858LmHugoOLXqUM+4TN8pnBb9tAB6sBp0QBpKrJ
         MdnQafIomtpmgieyn+goBfCEcu1zSnw8eE5HkCJlzbIcj+r/i+XGaa5W1F/UQCJ49RVW
         5v2V5tke3KCiV5upatmfo3QCP/8Nn5qDRxNBD34xr+AfpYXG6avuBTZ1NAyfLZP40N7U
         bp8xsLZFHriMABvCz2CdhSoL28vMMRsmjs0Yi+DhFt1vllOtG1RknIwlvVqvH2xdlHlH
         D21H0nQiknD4Ja7qkEZN6BFbmsYMvmPJipKpe2NUn8xRNY4haxLCzDCt9WYoxTeeWrds
         bVGQ==
X-Gm-Message-State: AOAM533SiMFIp4DHbPmAmk6NVp/pJcqYlJEXVzMZElfsivbxDv9X0LhN
        XDNBQYihwD0hHWScnE+v+JkLw0xuftiy
X-Google-Smtp-Source: ABdhPJxUFV8Wps4sXrXJJgYy5XHJZkNE3+UqXXV0SXsZ5Xlp6LLhxC4yYb9EwOgk6wNY6VpE7ndTbw==
X-Received: by 2002:ac8:4e0b:: with SMTP id c11mr15521030qtw.78.1604343638525;
        Mon, 02 Nov 2020 11:00:38 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id c6sm2911578qke.35.2020.11.02.11.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:00:38 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:00:36 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 05/17] mm/filemap: Inline __wait_on_page_locked_async
 into caller
Message-ID: <20201102190036.GH2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-6-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:00PM +0000, Matthew Wilcox (Oracle) wrote:
> The previous patch removed wait_on_page_locked_async(), so inline
> __wait_on_page_locked_async into __lock_page_async().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
