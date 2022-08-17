Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185A959772D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbiHQTx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 15:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241620AbiHQTxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:53:46 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94371EEDC
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 12:53:36 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z13so7417782ilq.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hEZIxBe/ExqP7zsKdZtdHr4635XpChkKa3yK0fzTdco=;
        b=nT/tg7iVBsnql8AAPz9H79cTk1UjdZ5nkFQ5s2J40wO4sFfxJ0PCSEKxep5njGlPzN
         Zb+DD2SB92tqUIgDBYychXe9dP55bKd5xN9uhh+BiH3KRnk8SHG+yFgGIIVKsTJ/+2iF
         ZsGZjaesJSj6wDDk1Zvh2dva7MoFeKJe7L0N4UCNCvBNJAbKIkChsIC+fe3JkcUBsKvN
         Qbf+38AMTzN8nBh6Mok66CJGWqtjjswxjjaAmk8MAvzQIeuiKkrOAADBhzhe1Pj4qqSt
         t+P4/2uZZBvj4iGXus+n+W+GaRbQjjHZX+zPGEp/99jKmt3KneOffNiz4UgUiWprqlAL
         IzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hEZIxBe/ExqP7zsKdZtdHr4635XpChkKa3yK0fzTdco=;
        b=Nakr7mn8Uq9PNB5KWUMH7SO72zqZR/JfIEd5YNvw1xSlfrK0qpBv6GnTP9JG8XTFNm
         aJnAwsXDp5ck/9fjww221s161ZL8TXjPcmFwETTQFE02jNvW+dP14JXDU+UPHsO273jz
         xJNRVVq13oqNkhhh/0f/MHpRmc8xm27qtpUNg2vwLvO4BYu6lGR+CawvhBMf8aHEOce1
         WFGABGzSgJhEUAO+7xluO6V3a5pXpVQlq9P8n50319U+zb+lI6UaLe4c5ETcXaRywsWt
         pDeK/qBNMxiIRrZak9o9FWl+uMgRvlm0wECtE8GPGNLEE6pUQsoK+SzGiKaIGe85x/qC
         WjAA==
X-Gm-Message-State: ACgBeo0RK3NgBU0QP81F6m38uossBP8gFSfm8eefeLymtqZlznCQH04Y
        h3DT7J9UrJFGKgQEBTk6orpv/2KaZ3dA8m8M3wpVjg==
X-Google-Smtp-Source: AA6agR7cABZ3BZEtSChr7XD/yzQACy3MMOxgGaxmfviXtZZ2J+i24gCYzD9uRUAEQu1gtALZU0kqAWXtEOwElvs5PsQ=
X-Received: by 2002:a92:da50:0:b0:2e8:f4f4:e505 with SMTP id
 p16-20020a92da50000000b002e8f4f4e505mr564940ilq.247.1660766016006; Wed, 17
 Aug 2022 12:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220808175614.3885028-1-axelrasmussen@google.com>
 <20220808175614.3885028-4-axelrasmussen@google.com> <YvSj2h7WgV1xd2Ht@kernel.org>
In-Reply-To: <YvSj2h7WgV1xd2Ht@kernel.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 17 Aug 2022 12:53:00 -0700
Message-ID: <CAJHvVchqCBsiZVuMc2b3jBgpeK+9LTp6tB-LBDrrcGkmjQqmLQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] userfaultfd: selftests: modify selftest to use /dev/userfaultfd
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 10, 2022 at 11:38 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Aug 08, 2022 at 10:56:12AM -0700, Axel Rasmussen wrote:
> > We clearly want to ensure both userfaultfd(2) and /dev/userfaultfd keep
> > working into the future, so just run the test twice, using each
> > interface.
> >
> > Instead of always testing both userfaultfd(2) and /dev/userfaultfd,
> > let the user choose which to test.
> >
> > As with other test features, change the behavior based on a new
> > command line flag. Introduce the idea of "test mods", which are
> > generic (not specific to a test type) modifications to the behavior of
> > the test. This is sort of borrowed from this RFC patch series [1], but
> > simplified a bit.
> >
> > The benefit is, in "typical" configurations this test is somewhat slow
> > (say, 30sec or something). Testing both clearly doubles it, so it may
> > not always be desirable, as users are likely to use one or the other,
> > but never both, in the "real world".
> >
> > [1]: https://patchwork.kernel.org/project/linux-mm/patch/20201129004548.1619714-14-namit@vmware.com/
> >
> > Acked-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>
> With a few nits below
>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks for reviewing, Mike!

>
> > ---
> >  tools/testing/selftests/vm/userfaultfd.c | 69 ++++++++++++++++++++----
> >  1 file changed, 60 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> > index 7c3f1b0ab468..cae72867c173 100644
> > --- a/tools/testing/selftests/vm/userfaultfd.c
> > +++ b/tools/testing/selftests/vm/userfaultfd.c
> > @@ -77,6 +77,11 @@ static int bounces;
> >  #define TEST_SHMEM   3
> >  static int test_type;
> >
> > +#define UFFD_FLAGS   (O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
> > +
> > +/* test using /dev/userfaultfd, instead of userfaultfd(2) */
> > +static bool test_dev_userfaultfd;
> > +
> >  /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
> >  #define ALARM_INTERVAL_SECS 10
> >  static volatile bool test_uffdio_copy_eexist = true;
> > @@ -125,6 +130,8 @@ struct uffd_stats {
> >  const char *examples =
> >      "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
> >      "./userfaultfd anon 100 99999\n\n"
> > +    "# Run the same anonymous memory test, but using /dev/userfaultfd:\n"
> > +    "./userfaultfd anon:dev 100 99999\n\n"
> >      "# Run share memory test on 1GiB region with 99 bounces:\n"
> >      "./userfaultfd shmem 1000 99\n\n"
> >      "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
> > @@ -141,6 +148,14 @@ static void usage(void)
> >               "[hugetlbfs_file]\n\n");
> >       fprintf(stderr, "Supported <test type>: anon, hugetlb, "
> >               "hugetlb_shared, shmem\n\n");
> > +     fprintf(stderr, "'Test mods' can be joined to the test type string with a ':'. "
> > +             "Supported mods:\n");
> > +     fprintf(stderr, "\tsyscall - Use userfaultfd(2) (default)\n");
> > +     fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");
> > +     fprintf(stderr, "\nExample test mod usage:\n");
> > +     fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
> > +     fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
> > +
> >       fprintf(stderr, "Examples:\n\n");
> >       fprintf(stderr, "%s", examples);
> >       exit(1);
> > @@ -154,12 +169,14 @@ static void usage(void)
> >                       ret, __LINE__);                         \
> >       } while (0)
> >
> > -#define err(fmt, ...)                                \
> > +#define errexit(exitcode, fmt, ...)          \
> >       do {                                    \
> >               _err(fmt, ##__VA_ARGS__);       \
> > -             exit(1);                        \
> > +             exit(exitcode);                 \
> >       } while (0)
> >
> > +#define err(fmt, ...) errexit(1, fmt, ##__VA_ARGS__)
> > +
> >  static void uffd_stats_reset(struct uffd_stats *uffd_stats,
> >                            unsigned long n_cpus)
> >  {
> > @@ -383,13 +400,29 @@ static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
> >       }
> >  }
> >
> > +static int __userfaultfd_open_dev(void)
> > +{
> > +     int fd, _uffd = -1;
>
> Nit: the initialization here is not necessary, _uffd is always set from
> ioctl() return value.

Agreed.

>
> > +
> > +     fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> > +     if (fd < 0)
> > +             return -1;
> > +
> > +     _uffd = ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
> > +     close(fd);
> > +     return _uffd;
> > +}
> > +
> >  static void userfaultfd_open(uint64_t *features)
> >  {
> >       struct uffdio_api uffdio_api;
> >
> > -     uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
> > +     if (test_dev_userfaultfd)
> > +             uffd = __userfaultfd_open_dev();
> > +     else
> > +             uffd = syscall(__NR_userfaultfd, UFFD_FLAGS);
> >       if (uffd < 0)
> > -             err("userfaultfd syscall not available in this kernel");
> > +             errexit(KSFT_SKIP, "creating userfaultfd failed");
>
> I'm not sure if this should be KSFT_SKIP. If creation of uffd failed
> because anything except ENOSYS I'd consider the test failing.

Agreed, but looking at it I think it's more complicated.

In __userfaultfd_open_dev, I think:
- If we fail to open /dev/userfaultfd for any reason, that's a KSFT_SKIP
- If USERFAULTFD_IOC_NEW returns ENOTTY that's a KSFT_SKIP, otherwise
a real test failure.

But then for syscall(__NR_userfaultfd, ...), I think ENOSYS is a
KSFT_SKIP, but any other errno is a real test failure.

I'll send an updated version which has those semantics. I think to do
so we need to move some of the error handling into
__userfaultfd_open_dev, instead of having its caller do it.

>
> >       uffd_flags = fcntl(uffd, F_GETFD, NULL);
> >
> >       uffdio_api.api = UFFD_API;
> > @@ -1584,8 +1617,6 @@ unsigned long default_huge_page_size(void)
> >
> >  static void set_test_type(const char *type)
> >  {
> > -     uint64_t features = UFFD_API_FEATURES;
> > -
> >       if (!strcmp(type, "anon")) {
> >               test_type = TEST_ANON;
> >               uffd_test_ops = &anon_uffd_test_ops;
> > @@ -1603,9 +1634,29 @@ static void set_test_type(const char *type)
> >               test_type = TEST_SHMEM;
> >               uffd_test_ops = &shmem_uffd_test_ops;
> >               test_uffdio_minor = true;
> > -     } else {
> > -             err("Unknown test type: %s", type);
> >       }
> > +}
> > +
> > +static void parse_test_type_arg(const char *raw_type)
> > +{
> > +     char *buf = strdup(raw_type);
> > +     uint64_t features = UFFD_API_FEATURES;
> > +
> > +     while (buf) {
> > +             const char *token = strsep(&buf, ":");
> > +
> > +             if (!test_type)
> > +                     set_test_type(token);
> > +             else if (!strcmp(token, "dev"))
> > +                     test_dev_userfaultfd = true;
> > +             else if (!strcmp(token, "syscall"))
> > +                     test_dev_userfaultfd = false;
> > +             else
> > +                     err("unrecognized test mod '%s'", token);
> > +     }
> > +
> > +     if (!test_type)
> > +             err("failed to parse test type argument: '%s'", raw_type);
> >
> >       if (test_type == TEST_HUGETLB)
> >               page_size = default_huge_page_size();
> > @@ -1653,7 +1704,7 @@ int main(int argc, char **argv)
> >               err("failed to arm SIGALRM");
> >       alarm(ALARM_INTERVAL_SECS);
> >
> > -     set_test_type(argv[1]);
> > +     parse_test_type_arg(argv[1]);
> >
> >       nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> >       nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
> > --
> > 2.37.1.559.g78731f0fdb-goog
> >
>
> --
> Sincerely yours,
> Mike.
