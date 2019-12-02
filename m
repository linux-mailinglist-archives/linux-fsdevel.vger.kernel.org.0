Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835B010EF76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfLBSoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 13:44:44 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43232 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfLBSom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:44:42 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so255948qvo.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 10:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lWgQk/yjEkof6+A6RJhzTS7OUGnQTEIgpDyVHRqaGKI=;
        b=Xd2IhhTZTpcta2HpOq8Glwijpm31ar4AczA2de+61pNAc9S+hIL+qWeJX+IrFMjo+C
         QJn9WAPdW0ndlQ0uEXGdj2QkVJ0ERICSD6oqEGoxCAsEWZHfGjGoYpHmWzhC4hIRQ8YD
         P/9SFpb5kuvt6vx23eENv0peanmM39eRkTqVtzyOj+EolLEkWrn0LFKhAJbZrG/LbGab
         7/7USbgyn9ZaJznvwSZ5p8H/cLsKhtfC1R9FS+lh1aGMljH9ICnSJToFTpBVpIETK0Jm
         4K2VCuOF+VkDJ1kO/su7RDF5eBISJSFBYg6XYz8Gm/QVOQre4/A9deWYTdd2laxHKO89
         VZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lWgQk/yjEkof6+A6RJhzTS7OUGnQTEIgpDyVHRqaGKI=;
        b=YMzHfFr6OdCn+83m+bwhCC/xk7qXcQR98bCsoeq8f/7Dk36jCLueisNgssYXgzl6/1
         ZYxcJdraC0yZVGE1f6nXbxiLPr2pNtWpwmqT2tkPLLtuvbpNGXYuTaHHxtMMdleovZNn
         gdL1n+k9DU4g8SlRrDWqqn1zAPlIJcvW0JrLgQvNj2w8yi8ItVt7JXh85ehqItsauhYd
         qFJfYMoRERytskXlItS6zXxqcDaVQQLS1Y7cRC1pxpeWJLKIGRooe1a+m8soUqx/UP9e
         8Xjx5SCWANdFdj4UvNBuGZ27wtW1dspxyyRF3I7BKKmNWomZ7DmbwOZk2vCvifdQ18Nw
         46Fg==
X-Gm-Message-State: APjAAAXco018fn3+fcwu7ma3qmR4u9EaOBPbM9+ePNrd2deWoUocu1fM
        S1K9YOXM3iWSpMhUATRq70M3cUWoaB31q9bwsR2Q
X-Google-Smtp-Source: APXvYqzMwz5owY2WFHcs6C3yfmFFs5JIVwGcO1bFusNGd+gCS4WlVuMUKR/2QgT03j3MXHqaDevITixc8oo/4DG7B2c=
X-Received: by 2002:a0c:b455:: with SMTP id e21mr524882qvf.72.1575312279611;
 Mon, 02 Dec 2019 10:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20191127095459.168324-1-zenczykowski@gmail.com>
In-Reply-To: <20191127095459.168324-1-zenczykowski@gmail.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Mon, 2 Dec 2019 10:44:03 -0800
Message-ID: <CAAXuY3oZSMYd8_f9dDSf_oktnC0oS6yKBJWOmcMi4Jn6C0MkkA@mail.gmail.com>
Subject: Re: [PATCH] proc_do_large_bitmap - return error on writes to
 non-existant bitmap
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus FS Devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 1:55 AM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
> We return ENOMEDIUM 'No medium found', because it's the best error
> I could come up with to describe the situation.
EFAULT for bitmap =3D=3D NULL and
EINVAL for bitmap_len =3D=3D 0?
