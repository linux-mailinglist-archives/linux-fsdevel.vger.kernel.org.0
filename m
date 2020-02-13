Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEDC15C3BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 16:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbgBMPoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 10:44:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36922 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgBMPoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:44:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so4599522lfc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K6511DdGifH8XUHZx9YT0KbpkCqEo3UTWf5Na2Wavuk=;
        b=h1O9Lk/39Nx/ytmuPKvu48NGNZk+XUil67BnaQeOVqW/Cxkpqv48zOF9nGwuUWlurM
         xa/u43X71SKX6da2a5fB2v7S6PgQbQBl2ssMQ94F9rVUv8LKIUdVh9zDvGRo4D5v6+nh
         LuEjK1SL9jGH9n9oTsRgAnTMwm6XTkEOF5/XYPKhJ4cpujsioAoAN8FERx3YESyPw37h
         9NEXptd6Gt16Vof39x76tD1yi5FL8D3RgfFYOqkR73ihPA21YsLTzKCgkmtI+79zgECg
         sL1BpHotERgS2c80OI6FTeoS+pGgJOQg0Eiig6Hakw1DtvSJOGUrK1sCxYJwoULIUzjm
         1cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K6511DdGifH8XUHZx9YT0KbpkCqEo3UTWf5Na2Wavuk=;
        b=Pn8IC7jafAOkdZDN29VzK7i5fjN9Gfr1skHnXQGZiA3qRs8D3ZkY2IMszwXxIkcCZX
         NrB5fgY9pGvi+XMzIWIf88YumhaLj5k8UsW/4a9Ym1FPeWZOR7mNc1+iMGgvLK0OVIEk
         Ql0kWMS8YpD9xJIb34e4+tChJ7Sz+RblSPSoKpTFjsgi6i8c6REec0rcSNWMP0INv7Gy
         NY2r7zo4nMUHisT/ULsknbpcIdTIYojTtki4V9oSoCHBLX1dx/DsMhAB+ok3UoswwVw9
         9yZREZ3jakc4P+35o6pmNTbJs48vHxPn4f9jECKqqU+IhtwBmjWpBSfbV5EtUGr9u1cR
         pu5g==
X-Gm-Message-State: APjAAAUNuAfumrgfGdCEK5GsmEUcAxBiK5+i5QIc/0UWMazZ5uLKdGxi
        w1axtRaW5ULUwbw9X+FciZNLUFgVu0U=
X-Google-Smtp-Source: APXvYqxrBJSTTk3KS21AJKxD2y7eTX8gC2feRkJ1tSpYCm6mG9Y6yhHM7jH/gQZsD+JKdEUN74SLWA==
X-Received: by 2002:a19:cb17:: with SMTP id b23mr9726567lfg.201.1581608638158;
        Thu, 13 Feb 2020 07:43:58 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u16sm1695370ljo.22.2020.02.13.07.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:43:57 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id C4400100F25; Thu, 13 Feb 2020 18:44:19 +0300 (+03)
Date:   Thu, 13 Feb 2020 18:44:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/25] fs: Make page_mkwrite_check_truncate thp-aware
Message-ID: <20200213154419.szxgd5tv2tjxmlz7@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-12-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:31PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> If the page is compound, check the appropriate indices and return the
> appropriate sizes.

Is it guarnteed that the page is never called on tail page?

-- 
 Kirill A. Shutemov
