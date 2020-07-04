Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB121480F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGDSii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 14:38:38 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:33260 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgGDSih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 14:38:37 -0400
Received: by mail-oo1-f66.google.com with SMTP id d125so3237499oob.0;
        Sat, 04 Jul 2020 11:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfjUpuKXHj7Ihv4sk2DDkgXbkuhS8XCG6LKodnrJh+c=;
        b=JECf44xHCIihKYBcPeNL0ar5fG6lddhDEiZ5nhZSa6Awvav4fHs1/ZMbVaOAnSeWEz
         1ldzVZyq9x7hOxqMpuJRgVfQap7Kg25yYpWf0vzd8+Nphkf3CT8Mioy7MAbc5vRadSYm
         qvCBv7aKKcRd7/rt0l7+EnkG2AavPSgEVOibhYUGcCNq8I/cn9RCPQtP19nHzQe61AxU
         rbiDzWFKpjt6//Iha3J5kzjRgHQteaBUdCm5TVd0UTryKkEafkyzeDMt7uIV5SPRX3u5
         APwuoq9KPoWsSYEu+/TJ5hM3xgsqw8n+H3naNlOhtawbSGKSkZ9BcSGPUSK/Di4spUu7
         nXBA==
X-Gm-Message-State: AOAM530qpZwiofwejZNy/D/20Cn8ODJFF/sxyjb9IrV5tHwre4g3dj3j
        UT2lZa0yxnTLY4M4vuwn+1vv6jfkChF15Co55Y0=
X-Google-Smtp-Source: ABdhPJx/zSOajNIyEy/VtKhKFJnwgrEjiDN8NElOIJmNaKURhfCvHdTZXS/EK4QonPjNHRcAgly08mvw3MSRrP7kCN8=
X-Received: by 2002:a4a:5744:: with SMTP id u65mr36264557ooa.1.1593887917099;
 Sat, 04 Jul 2020 11:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200704140250.423345-1-gregkh@linuxfoundation.org> <20200704140250.423345-4-gregkh@linuxfoundation.org>
In-Reply-To: <20200704140250.423345-4-gregkh@linuxfoundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 4 Jul 2020 20:38:26 +0200
Message-ID: <CAMuHMdXck1u+Djv1xOvRA7riMN4m3qp8o4zmXVvqrC1S+0fifA@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests: add readfile(2) selftests
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-man@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On Sat, Jul 4, 2020 at 4:05 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Test the functionality of readfile(2) in various ways.
>
> Also provide a simple speed test program to benchmark using readfile()
> instead of using open()/read()/close().
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Any benchmark results to share?

> --- /dev/null
> +++ b/tools/testing/selftests/readfile/readfile.c

> +static void readfile(const char *filename)
> +{
> +//     int root_fd;

???

> +       unsigned char buffer[16000];
> +       int retval;
> +
> +       memset(buffer, 0x00, sizeof(buffer));
> +
> +//     root_fd = open("/", O_DIRECTORY);
> +//     if (root_fd == -1)
> +//             ksft_exit_fail_msg("error with root_fd\n");

???

> +
> +       retval = sys_readfile(root_fd, filename, &buffer[0], sizeof(buffer), 0);
> +
> +//     close(root_fd);
> +
> +       if (retval <= 0)
> +               ksft_test_result_fail("readfile() test of filename=%s failed with retval %d\n",
> +                                     filename, retval);
> +       else
> +               ksft_test_result_pass("readfile() test of filename=%s succeeded with retval=%d\n",
> +                                     filename, retval);
> +//     buffer='%s'\n",
> +//            filename, retval, &buffer[0]);
> +
> +}
> +
> +
> +int main(int argc, char *argv[])
> +{
> +       ksft_print_header();
> +       ksft_set_plan(10);
> +
> +       test_readfile_supported();      // 1 test
> +
> +       test_sysfs_files();             // 1 test
> +
> +       test_filesizes();               // 6 tests
> +
> +       setup_tmpdir();
> +
> +       readfile(TEST_FILE1);
> +       readfile(TEST_FILE2);
> +//     readfile(TEST_FILE4);

???

> +
> +       teardown_tmpdir();
> +
> +       if (ksft_get_fail_cnt())
> +               return ksft_exit_fail();
> +
> +       return ksft_exit_pass();
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
