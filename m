Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6D56EAD5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 16:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjDUOrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjDUOri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:47:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05741B46C
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 07:47:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so12863283a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1682088437; x=1684680437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wUokQ2DK9bFFCVCWMNulrcsWUwPnufGkuzOAC1+OXUM=;
        b=S20sE6wMkev/E/bRaPDo0Br/uExptBzPWQyg77sB4B+7Ol/mCvSWossHVZpTXZ2DsX
         kJhhIfUoMtwZ8B2txNbSzsi7itBFTHnaXsjktXfRq3AQzROKHwGu2jYLSGfzALTg0Zr5
         gAWda60XPV92fzgpcZb5Nkx9ab+aJnBeA+zcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682088437; x=1684680437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUokQ2DK9bFFCVCWMNulrcsWUwPnufGkuzOAC1+OXUM=;
        b=gjSCNiZNc3dLV+sJ6G/3Ebobv7wmrYhLkq79IIzxUUHwZ0ipc4wD9cpgaWCa9K2a17
         bT3RXdgrZKhZl37RoFtqDsd/GFWPlyJOLkIVOiO5KGJVvonxHLNil/dZmyp0maM++lY+
         qVhD8AHOeYd5uTDvu2JEIM4k0KrQbevlBj2Aty1spxYJGTKSSIPIf9F9qaMftyo3XwO/
         K96+B7cEFhdFtmO+5jwvylWXYjEQXJb+knvrqkvAah77k4xwWL8kX73uu8e486q+2ZCA
         PLPtid9JdGjJ3Tc6cUYPEcaiDsAOi03PtDek8oP0Ov/9W7XaA1ppVXojM06M7Z9tBQky
         /0dQ==
X-Gm-Message-State: AAQBX9d3Qn7M7mb29+GLmlW6xW5xXalwggXVb7DYrT0Q2uXN8jNcoWgs
        t50W9FDAfW72df8zgCs9jddTkSls4C/j2VW6v4405g==
X-Google-Smtp-Source: AKy350ZXNIcmFEWOOVhIcPfhQDYl/AlaGPfxDhqMHMKETV3Av2fOkq/KdbXjVg3uenlldoPYvqCDaPaFp1DJMx0bU/s=
X-Received: by 2002:a17:906:d1cb:b0:957:9ddd:8809 with SMTP id
 bs11-20020a170906d1cb00b009579ddd8809mr307823ejb.35.1682088437540; Fri, 21
 Apr 2023 07:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230417075545.58817-1-xurongbo@baidu.com>
In-Reply-To: <20230417075545.58817-1-xurongbo@baidu.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Apr 2023 16:47:06 +0200
Message-ID: <CAJfpegswN_CJJ6C3RZiaK6rpFmNyWmXfaEpnQUJ42KCwNF5tWw@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] fuse: no interrupt for lookup request
To:     Xu Rongbo <xurongbo@baidu.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cd1ab605f9d9bbc4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000cd1ab605f9d9bbc4
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Apr 2023 at 09:59, Xu Rongbo <xurongbo@baidu.com> wrote:
>
> From: xurongbo <xurongbo@baidu.com>
>
> if lookup request interrupted, then dentry revalidate return -EINTR
> will umount bind-mounted directory.
>

Thanks for the report.

Could you please verify that the attached fix also works?

Thanks,
Miklos

--000000000000cd1ab605f9d9bbc4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-dont-invalidatate-if-interrupted.patch"
Content-Disposition: attachment; 
	filename="fuse-dont-invalidatate-if-interrupted.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lgqnzvdo0>
X-Attachment-Id: f_lgqnzvdo0

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IGZ1c2U6
IHJldmFsaWRhdGU6IGRvbid0IGludmFsaWRhdGUgaWYgaW50ZXJydXB0ZWQKCklmIHRoZSBMT09L
VVAgcmVxdWVzdCB0cmlnZ2VyZWQgZnJvbSBmdXNlX2RlbnRyeV9yZXZhbGlkYXRlKCkgaXMKaW50
ZXJydXB0ZWQsIHRoZW4gdGhlIGRlbnRyeSB3aWxsIGJlIGludmFsaWRhdGVkLCBwb3NzaWJseSBy
ZXN1bHRpbmcgaW4Kc3VibW91bnRzIGJlaW5nIHVubW91bnRlZC4KClJlcG9ydGVkLWJ5OiBYdSBS
b25nYm8gPHh1cm9uZ2JvQGJhaWR1LmNvbT4KRml4ZXM6IDllNjI2OGRiNDk2YSAoIltQQVRDSF0g
RlVTRSAtIHJlYWQtd3JpdGUgb3BlcmF0aW9ucyIpCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9y
Zz4KU2lnbmVkLW9mZi1ieTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+Ci0t
LQogZnMvZnVzZS9kaXIuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKLS0tIGEvZnMvZnVzZS9kaXIuYworKysgYi9mcy9mdXNlL2Rpci5j
aQpAQCAtMjU4LDcgKzI1OCw3IEBAIHN0YXRpYyBpbnQgZnVzZV9kZW50cnlfcmV2YWxpZGF0ZShz
dHJ1Y3QKIAkJCXNwaW5fdW5sb2NrKCZmaS0+bG9jayk7CiAJCX0KIAkJa2ZyZWUoZm9yZ2V0KTsK
LQkJaWYgKHJldCA9PSAtRU5PTUVNKQorCQlpZiAocmV0ID09IC1FTk9NRU0gfHwgcmV0ID09IC1F
SU5UUikKIAkJCWdvdG8gb3V0OwogCQlpZiAocmV0IHx8IGZ1c2VfaW52YWxpZF9hdHRyKCZvdXRh
cmcuYXR0cikgfHwKIAkJICAgIGZ1c2Vfc3RhbGVfaW5vZGUoaW5vZGUsIG91dGFyZy5nZW5lcmF0
aW9uLCAmb3V0YXJnLmF0dHIpKQo=
--000000000000cd1ab605f9d9bbc4--
